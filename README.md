# BC Hospitalized Seniors at Risk of Frailty: An SPC Analysis
 
A statistical process control analysis of a public CIHI health indicator, asking a simple question: is British Columbia seeing a real change in hospitalized senior frailty risk over the last decade, or is this just normal year to year variation.
 
## Background
 
CIHI's Hospitalized Seniors at Risk of Frailty indicator measures the proportion of hospitalized seniors (65+) with six or more frailty-related deficits, based on data from Canada's Discharge Abstract Database (DAD). This project uses that public indicator as a working example of the kind of administrative health data analysis done by teams like Health Quality BC, applying an SPC approach rather than a simple before/after comparison.
 
## The question
 
Are recent frailty risk numbers in BC hospitals meaningfully different from historical experience, or does the year to year movement fall within expected variation. This matters because SPC is built for exactly this kind of question: distinguishing a real signal worth acting on from ordinary noise, without needing a formal inferential study.
 
## Data
 
Source: CIHI, Hospitalized Seniors at Risk of Frailty, public data table (facility, corporation, health region, and province/territory level, fiscal years 2015-16 through 2024-25).
 
The raw file includes six health authorities in BC, but only Vancouver Coastal Health and PHSA report at an aggregate (corporation or health region) level. Fraser, Interior, Island, and Northern Health only report this indicator at the individual facility level, with no authority-wide rollup. Facility-level data also carries most of the suppression in this dataset (close to 12 percent of facility rows, versus zero at the provincial level). Given that, this analysis uses the BC provincial trend, which has complete, unsuppressed data for all ten fiscal years.
 
## Method
 
- Data cleaned and validated in R (tidyverse, janitor), with explicit handling of CIHI's suppressed-cell codes rather than treating them as ordinary missing values
- Provincial subset extracted with SQL (via DBI/RSQLite), mirroring a filter-then-analyze workflow common in health data teams
- SPC analysis in R using `qicharts2`, specifically an individuals (I) chart, since no denominator is available at the provincial level to support a rate-based p-chart
- Control limits recalculated using a frozen pre-2020 baseline, to confirm that any apparent post-2020 shift is real relative to prior experience rather than an artifact of limits calculated across the full time series
## Findings, in short
 
The data shows two separate signals, not one: a sustained dip below the lower control limit from 2016-17 through 2019-20, and a sustained rise above the upper control limit starting in 2021-22 (confirmed against a frozen pre-2020 baseline). The post-2021 rise fits what's known about pandemic-era disruption to hospital care and post-COVID deconditioning. The pre-2020 dip does not have a clear explanation tied to COVID, since it starts years before the pandemic reached BC, and is left as an open question rather than forced into a single tidy story.
 
Full reasoning, including the exact control limit values, the small-sample caveats, and what this analysis can't tell you, is in [INTERPRETATION.md](INTERPRETATION.md).
 
## Reproducing this analysis
 
1. Download the CIHI data table for this indicator from CIHI's public data site.
2. Update `file_path` in `frailty_spc_analysis.Rmd` to point to your local copy.
3. Knit the R Markdown file. It will clean the raw data, build a local SQLite database, extract the BC provincial subset, and generate both the full-series and frozen-baseline SPC charts.
Requires R with the following packages: tidyverse, janitor, lubridate, DBI, RSQLite, qicharts2, readxl.
 
## Files
 
- `frailty_spc_analysis.Rmd` — full analysis, from raw data through SPC charts
- `01_clean_frailty_data.R` — standalone version of the cleaning step
- `INTERPRETATION.md` — full interpretation and limitations write-up
## Data source
 
Canadian Institute for Health Information (CIHI), Hospitalized Seniors at Risk of Frailty indicator. Public data, available at cihi.ca.
 
