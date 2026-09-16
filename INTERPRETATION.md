# Interpretation and Limitations
 
## Interpretation
 
The full time series shows two separate signals, not one. Fiscal years 2016-17 through 2019-20 sit below the lower control limit, and 2022-23 through 2024-25 sit above the upper control limit. 2015-16, 2020-21, and 2021-22 fall within limits.
 
Using all ten points to calculate the control limits means the post-2020 rise is judged partly against limits that the post-2020 rise itself helped set. To check whether that rise holds up independent of that effect, the control limits were recalculated using only the five pre-2020 points as a fixed baseline, then all ten points were plotted against those fixed limits. Against that frozen baseline (centerline 23.18, upper limit 25.04, lower limit 21.32), the signal starts at 2021-22 rather than 2022-23, a year earlier than the full-series chart suggested. 2020-21 itself sits close to the centerline and within limits, meaning the disruption doesn't show up in the pandemic year itself. It shows up the year after.
 
The post-2021 rise is consistent with disrupted hospital care pathways and post-pandemic deconditioning among seniors. The pre-2020 decline does not have an obvious explanation tied to COVID, since it begins three to four years before the pandemic reached BC. It could reflect a change in CIHI's indicator methodology, a genuine pre-pandemic improvement, a shift in coding practice, or something else not identified here. It's treated as an open question rather than folded into a single before and after COVID story that the timing doesn't actually support. Only one of the two shifts has a plausible explanation attached to it, and this write-up says so directly rather than implying both do.
 
Worth being precise about the frozen baseline itself: it isn't a clean, stable "normal" period. It includes the years already flagged as a below-average cluster in the full-series chart (2016-17 through 2019-20), so the frozen limits are anchored on a period that already contains its own shift. That doesn't undermine the post-2021 finding, which holds up regardless, but it means the right way to describe the comparison is "relative to pre-pandemic experience," not "relative to a stable baseline."
 
This is signal detection meant to support a quality improvement question: is something worth investigating and acting on, not a research study aimed at establishing a generalizable cause. That distinction shaped every choice here, from using control charts instead of a significance test, to stopping at "this deserves a closer look" rather than asserting a mechanism the data can't actually support.
 
## Limitations
 
Ten data points total, and the frozen baseline analysis uses five of them. Control limits based on the moving range between consecutive points are less stable with samples this small, and that instability should be assumed rather than treated as a minor caveat.
 
No denominator is available at the provincial level for this indicator (it's suppressed everywhere except the national rollup), so this analysis uses an individuals chart rather than a rate-based p-chart. A p-chart would account for changes in the underlying population size over time in a way this can't.
 
Four of BC's six health authorities (Fraser, Interior, Island, Northern Health) have no aggregate-level rows in this public indicator at all, only individual facility rows, and facility-level data carries most of the suppression in the full dataset. An authority-by-authority comparison was considered and dropped for this reason. The provincial trend used here was the cleanest reliable level available, not necessarily the most operationally useful one.
 
This project uses a public CIHI indicator as a stand-in for the kind of internal administrative data (DAD, PharmaNet, NACRS) that a team like Health Quality BC would work with directly. The public indicator's definition and refresh cycle won't match an internal dataset exactly, so this should be read as a demonstration of method and reasoning, not as a finding about BC's actual frailty burden that would hold up to an internal analyst's scrutiny of the underlying data.
 
A supplementary run chart was also generated. Its automated signal output didn't match what the raw crossing count in the underlying data would suggest, and that discrepancy wasn't resolved. The run chart is included as a secondary visual only. The interpretation above rests entirely on the individuals chart results, not the run chart.
 
