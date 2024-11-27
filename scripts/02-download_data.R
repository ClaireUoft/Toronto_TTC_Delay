#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: The `tidyverse` package must be installed
# Any other information needed? N/A


#### Workspace setup ####
library(opendatatoronto)
library(here)
library(tidyverse)

#### Download data ####

# get all the bus data
bus_data <- list_package_resources("e271cdae-8788-4980-96ce-6a5c95bc6618") |>
  filter(name == "ttc-bus-delay-data-2024") |>
  get_resource()

#subway data 
subway_data <- list_package_resources("996cfe8d-fb35-40ce-b569-698d51fc683b") |>
  filter(name == "ttc-subway-delay-data-2024") |>
  get_resource()

#get Streetcar Data
streetcar_data <- list_package_resources("b68cb71b-44a7-4394-97e2-5d2f41462a5d") |>
  filter(name == "ttc-streetcar-delay-data-2024") |>
  get_resource()

#### Save data ####
write_csv(bus_data, here::here("data/01-raw_data/raw_data_bus.csv"))
write_csv(subway_data, here::here("data/01-raw_data/raw_data_subway.csv"))
write_csv(streetcar_data, here::here ("data/01-raw_data/raw_data_streetcar.csv"))
