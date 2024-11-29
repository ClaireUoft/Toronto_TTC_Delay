#### Preamble ####
# Purpose: This script creates a Bayesian linear model to predict TTC transit delays by transit mode and saves the model as an RDS file in the models directory.
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure the `tidyverse`, `here`, and `rstanarm`packages are installed.
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)
library(here)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet(here::here("data/02-analysis_data/cleaned_combined_data.parquet"))

#### Prepare Data for Delay Duration Analysis ####
# Ensure Min Delay is numeric
analysis_data <- analysis_data %>%
  mutate(`Min Delay` = as.numeric(`Min Delay`))

# Filter out any NA values in Min Delay to avoid errors in modeling
analysis_data <- analysis_data %>%
  filter(!is.na(`Min Delay`))

#### Model Delay Duration ####
# Fit a linear regression model for delay duration using transit mode, time, and day
set.seed(304)
analysis_data_sample <- analysis_data %>% sample_frac(0.1)

first_model <- stan_glm(
  formula = `Min Delay` ~ Transit_mode + Time + Day,
  data = analysis_data_sample,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 304
)

#### Save model ####
saveRDS(
  first_model, here::here("models/first_model.rds"))


