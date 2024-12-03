#### Preamble ####
# Purpose: Tests the structure and validity of the simulated TTC bus, subway, and streetcar dataset.
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? None. 

#### Workspace setup ####
library(testthat)
library(tidyverse)

#### Load simulated data ####
simulated_data <- read_csv(here::here("data/00-simulated_data/simulated_data.csv"))



#### Tests ####

# Test that the dataset has the correct number of rows
test_that("Dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Test that the 'month' column contains values from 1 to 12
test_that("Month column contains values from 1 to 12", {
  expect_true(all(simulated_data$month %in% 1:12))
})

# Test that the 'day' column contains values from 1 to 31
test_that("Day column contains values from 1 to 31", {
  expect_true(all(simulated_data$day %in% 1:31))
})

# Test that the 'weekday' column contains valid day names
test_that("Weekday column contains valid day names", {
  valid_weekdays <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
  expect_true(all(simulated_data$weekday %in% valid_weekdays))
})

# Test that the 'hour' column contains values from 0 to 23
test_that("Hour column contains values from 0 to 23", {
  expect_true(all(simulated_data$hour %in% 0:23))
})

# Test that the 'minute' column contains values from 0 to 59
test_that("Minute column contains values from 0 to 59", {
  expect_true(all(simulated_data$minute %in% 0:59))
})

# Test that the 'line' column contains only valid line numbers
test_that("Line column contains valid line numbers (1, 2, 3)", {
  expect_true(all(simulated_data$line %in% c("1", "2", "3")))
})

# Test that the 'Transit_mode' column contains valid transit types
test_that("Transit_mode column contains valid transit types", {
  valid_modes <- c("Subway", "Bus", "Streetcar")
  expect_true(all(simulated_data$Transit_mode %in% valid_modes))
})

# Test that the 'incident' column contains valid incident types
test_that("Incident column contains valid incident types", {
  valid_incidents <- c("Mechanical", "Operations", "General Delay", "Emergency")
  expect_true(all(simulated_data$incident %in% valid_incidents))
})

# Test that the 'delay' column contains values from 0 to 47 minutes
test_that("Delay column contains values from 0 to 47 minutes", {
  expect_true(all(simulated_data$delay %in% 0:47))
})
