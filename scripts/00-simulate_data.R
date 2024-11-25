#### Preamble ####
# Purpose: Simulates a dataset of bus, subway, and streetcar
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: download and clean data 
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)
set.seed(304)

#### Simulate data ####

num_obs <- 1000 

simulated_data <- 
  tibble(
    year = 2024,
    month = sample(1:12, num_obs, replace = TRUE),
    day = sample(1:31, num_obs, replace = TRUE),
    weekday = sample(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                       "Friday", "Saturday"), num_obs, replace = TRUE),
    hour = sample(0:23, num_obs, replace = TRUE),
    minute = sample(0:59, num_obs, replace = TRUE),
    line = sample(c("1", "2", "3"), num_obs, replace = TRUE),
    Transit_mode = sample(c("Subway", "Bus", "Streetcar"), num_obs, replace = TRUE),
    incident = sample(c("Mechanical", "Operations", "General Delay", "Emergency"), num_obs, replace = TRUE),
    delay = sample(0:47, num_obs, replace = TRUE),
  )

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
