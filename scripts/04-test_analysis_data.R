#### Preamble ####
# Purpose: Tests the analysis dataset for correctness
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 03-clean_data.R must have been run
# Any other information needed? None.

#### Workspace Setup ####
library(tidyverse)
library(testthat)
library(arrow)

#### Load Cleaned Data ####
cleaned_combined_data <- read_parquet(here::here("data/02-analysis_data/cleaned_combined_data.parquet"))

#### Test Data ####
# Test that the cleaned dataset has the correct columns
test_that("Dataset has correct columns", {
  expected_columns <- c("Date", "Time", "Day", "Transit_mode", "Line", "Location", "Incident", "Min Delay")
  actual_columns <- colnames(cleaned_combined_data)
  expect_equal(actual_columns, expected_columns)
})


# Test that the 'Transit_mode' column contains valid values
test_that("Transit_mode column contains valid values", {
  valid_modes <- c("Subway", "Bus", "Streetcar")
  invalid_modes <- cleaned_combined_data$Transit_mode[!(cleaned_combined_data$Transit_mode %in% valid_modes)]
  expect_true(
    all(cleaned_combined_data$Transit_mode %in% valid_modes),
    info = paste("Invalid Transit_mode values found:", paste(invalid_modes, collapse = ", "))
  )
})


# Test that the 'Incident' column contains valid incidents
test_that("Incident column contains valid incident types", {
  valid_incidents <- c("Mechanical", "Operations", "General Delay", "Emergency Services", 
                       "Security", "Cleaning", "Diversion", "Collision", "Investigation", 
                       "Held By", "Vision", "Late Entering Service", "Overhead", 
                       "Rail/Switches", "N/A")
  invalid_incidents <- cleaned_combined_data$Incident[!(cleaned_combined_data$Incident %in% valid_incidents)]
  expect_true(
    all(cleaned_combined_data$Incident %in% valid_incidents),
    info = paste("Invalid Incident values found:", paste(invalid_incidents, collapse = ", "))
  )
})

# Test that the 'Min Delay' column contains values from 0 or greater (assuming it represents minutes of delay)
test_that("'Min Delay' column contains non-negative numeric values", {
  expect_true(
    all(cleaned_combined_data$`Min Delay` >= 0),
    info = paste("Invalid 'Min Delay' values found:", paste(cleaned_combined_data$`Min Delay`[cleaned_combined_data$`Min Delay` < 0], collapse = ", "))
  )
})





