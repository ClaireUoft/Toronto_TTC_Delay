#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("/Users/claire/Downloads/Toronto_Transportation-main 2/data/02-analysis_data/cleaned_combined_data.parquet")

#### Prepare Data for Delay Duration Analysis ####
# Ensure Min Delay is numeric
analysis_data <- analysis_data %>%
  mutate(Min_Delay = as.numeric(`Min Delay`))

# Filter out any NA values in Min Delay to avoid errors in modeling
analysis_data <- analysis_data %>%
  filter(!is.na(Min_Delay))

#### Model Delay Duration ####
# Fit a linear regression model for delay duration using transit mode, time, and day
first_model <- 
  stan_glm(
    formula = Min_Delay ~ Transit_mode + Time + Day,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

#### Save model ####
saveRDS(
  first_model,
  file = "/Users/claire/Downloads/Toronto_Transportation-main 2/models/first_model.rds"
)


