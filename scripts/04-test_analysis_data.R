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

#### Load Analysis Data ####
# Load the analysis data from the parquet file
analysis_data <- read_parquet("/full/path/to/data/02-analysis_data/analysis_data.parquet")

#### Tests ####

# Test that the dataset has the correct number of rows (adjust as needed)
test_that("Dataset has 84125 rows", {
  expect_equal(nrow(analysis_data), 84125)
})

# Test that the 'month' column contains values from 1 to 12 (assuming there is a 'month' column)
test_that("Month column contains values from 1 to 12", {
  expect_true(all(analysis_data$month %in% 1:12))
})

# Test that the 'day' column contains values from 1 to 31 (assuming there is a 'day' column)
test_that("Day column contains values from 1 to 31", {
  expect_true(all(analysis_data$day %in% 1:31))
})

# Test that the 'weekday' column contains valid day names (assuming there is a 'weekday' column)
test_that("Weekday column contains valid day names", {
  valid_weekdays <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
  expect_true(all(analysis_data$weekday %in% valid_weekdays))
})

# Test that the 'hour' column contains values from 0 to 23 (assuming there is an 'hour' column)
test_that("Hour column contains values from 0 to 23", {
  expect_true(all(analysis_data$hour %in% 0:23))
})

# Test that the 'minute' column contains values from 0 to 59 (assuming there is a 'minute' column)
test_that("Minute column contains values from 0 to 59", {
  expect_true(all(analysis_data$minute %in% 0:59))
})

# Test that the 'line' column contains only valid line numbers (assuming there is a 'line' column)
test_that("Line column contains valid line numbers (1, 2, 3)", {
  expect_true(all(analysis_data$line %in% c("1", "2", "3")))
})

# Test that the 'Transit_mode' column contains valid transit types (assuming there is a 'Transit_mode' column)
test_that("Transit_mode column contains valid transit types", {
  valid_modes <- c("Subway", "Bus", "Streetcar")
  expect_true(all(analysis_data$Transit_mode %in% valid_modes))
})

# Test that the 'incident' column contains valid incident types (assuming there is an 'incident' column)
test_that("Incident column contains valid incident types", {
  valid_incidents <- c("Mechanical", "Operations", "General Delay", "Emergency")
  expect_true(all(analysis_data$incident %in% valid_incidents))
})

# Test that the 'delay' column contains values from 0 to 47 minutes (assuming there is a 'delay' column)
test_that("Delay column contains values from 0 to 47 minutes", {
  expect_true(all(analysis_data$delay %in% 0:47))
})
