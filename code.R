library(tidyverse)
library(janitor)
library(lubridate)
library(DBI)
library(RSQLite)
library(qicharts2)
library(readxl)

file_path <- "C:/Users/dhanv/OneDrive/Desktop/applications/HQBC/senior_frailty/821-hospitalized-seniors-at-risk-of-frailty-data-table-en.xlsx"



raw <- read_excel(file_path, sheet = "Table 1", skip = 1, col_types = "text") %>%
  clean_names()

target_col_name <- "hospitalized_seniors_at_risk_of_frailty_percent_6_or_more_deficits"
risk_group_cols <- names(raw)[str_starts(names(raw), "risk_group")]

stopifnot(
  target_col_name %in% names(raw),
  "denominator" %in% names(raw),
  "median_of_deficits" %in% names(raw),
  length(risk_group_cols) > 0
)

# Update based on what count(raw, .data[[target_col_name]]) actually shows
suppression_pattern <- regex("suppress|^n/?a$|^ns$|^\\*+$|^-+$|^<\\s*\\d+$", ignore_case = TRUE)

bc_frailty <- raw %>%
  mutate(
    is_suppressed    = str_detect(str_trim(.data[[target_col_name]]), suppression_pattern),
    frailty_rate_pct = suppressWarnings(as.numeric(.data[[target_col_name]])),
    unrecognized     = is.na(frailty_rate_pct) & !is_suppressed & !is.na(.data[[target_col_name]])
  ) %>%
  mutate(across(c(denominator, median_of_deficits, all_of(risk_group_cols)),
                ~ suppressWarnings(as.numeric(.x))))

stopifnot("Unrecognized non-numeric values in target column - inspect before continuing" =
            sum(bc_frailty$unrecognized) == 0)

bc_frailty <- select(bc_frailty, -unrecognized)


# 2-Save to local SQLite database
con <- dbConnect(RSQLite::SQLite(), "frailty.db")
dbWriteTable(con, "frailty_data", bc_frailty, overwrite = TRUE)

sql_query <- "SELECT
  time_frame AS fiscal_year,
  reporting_level,
  frailty_rate_pct,
  is_suppressed
FROM frailty_data
WHERE province_territory = 'British Columbia'
  AND reporting_level = 'Province/territory'
ORDER BY time_frame ASC;
"

working_subset <- dbGetQuery(con, sql_query)

#sanity check
nrow(working_subset)                          
working_subset %>% summarise(n_suppressed = sum(is_suppressed))

dbDisconnect(con)

head(working_subset)


qic(
  x = fiscal_year,
  y = frailty_rate_pct,
  data = working_subset,
  chart = "i",
  title = "BC: Hospitalized Seniors at Risk of Frailty (%)",
  ylab = "% of seniors at risk of frailty (6+ deficits)",
  xlab = "Fiscal Year"
)

qic(
  x = fiscal_year,
  y = frailty_rate_pct,
  data = working_subset,
  chart = "run",
  title = "BC: Hospitalized Seniors at Risk of Frailty (%)",
  ylab = "% of seniors at risk of frailty (6+ deficits)",
  xlab = "Fiscal Year"
)


run_result <- qic(x = fiscal_year, y = frailty_rate_pct, data = working_subset, chart = "run")
run_result$data  # or just print(run_result) at console — look for the signal columns


freeze_result <- qic(
  x     = fiscal_year,
  y     = frailty_rate_pct,
  data  = working_subset,
  chart = "i",
  freeze = 5,   #baseline = 2015-2016 through 2019-2020 (rows 1-5)
  title = "BC: Hospitalized Seniors at Risk of Frailty (%) - Frozen Baseline (Pre-2020)",
  ylab  = "% of seniors at risk of frailty (6+ deficits)",
  xlab  = "Fiscal Year"
)

freeze_result
freeze_result$data


working_subset <- working_subset %>%
  mutate(fy_index = row_number())  

freeze_result <- qic(
  x = fy_index, y = frailty_rate_pct, data = working_subset,
  chart = "i", freeze = 5,
  title = "BC: Hospitalized Seniors at Risk of Frailty (%) - Frozen Baseline (Pre-2020)",
  ylab = "% of seniors at risk of frailty (6+ deficits)", xlab = "Fiscal Year"
)

freeze_result
scale_x_continuous(breaks = 1:10, labels = working_subset$fiscal_year)

freeze_result$data[, c("x","y","cl","ucl","lcl","sigma.signal")]
