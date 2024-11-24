#### Preamble ####
# Purpose: Cleans the raw streetcar data into an analyzable dataset 
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded the data
# Any other information needed? Knowledge of existing streetcar lines


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####

raw_data_bus <- read_csv("data/01-raw_data/raw_data_bus.csv")
raw_data_streetcar <- read_csv("data/01-raw_data/raw_data_streetcar.csv")
raw_data_subway <- read_csv("data/01-raw_data/raw_data_subway.csv")

## Add Type of Vehicle ##
raw_data_subway$Transit_mode <- "Subway"
raw_data_streetcar$Transit_mode <- "Streetcar"
raw_data_bus$Transit_mode <- "Bus"

#### Clean Subway Data ####

clean_data_subway <- raw_data_subway |> 
# Remove unnecessary columns
select(-Code, -Bound, -Vehicle, -`Min Gap`) |>
  
# Add new columns for vehicle type and incident
mutate(
Transit_mode = "Subway",
incident = "NA",
Line = case_match(
    Line,
    "YU" ~ "1",
    "BD" ~ "2", 
    "SRT" ~ "3", 
    "SHP" ~ "4",
    "YU / BD" ~ "1",
    "BD/YU" ~ "2", 
    "BLOOR DANFORTH & YONGE" ~ "2",
    "YUS/BD" ~ "1",
    "BD LINE 2" ~ "2", 
    "999" ~ "NA",
    "YUS" ~ "1",
    "YU & BD" ~ "1",
    "77 SWANSEA" ~ "NA",
    .default = Line  # Handle unmatched values without errors
  )
) |>
  
# Rename columns and select only the needed ones
rename(Location = Station, Incident = incident) |>
select(Date, Time, Day, Transit_mode, Line, Location, Incident, `Min Delay`) |>
  
# Ensure Line is a character type
mutate(Line = as.character(Line))

## Clean streetcar ##
clean_data_streetcar <- raw_data_streetcar |> 
  select(-Bound, -Vehicle, -`Min Gap`) |>
  select(Date, Time, Day, Transit_mode, Line, Location, Incident, `Min Delay`) |>
  mutate(Line = as.character(Line))

## Clean bus ##
clean_data_bus <- raw_data_bus |> 
  select(-Direction, -Vehicle, -`Min Gap`) |>
  rename(Line = Route) |>
  select(Date, Time, Day, Transit_mode, Line, Location, Incident, `Min Delay`) |>
  mutate(Line = as.character(Line))

#Combine the three datasets 
combined_data <- bind_rows(clean_data_bus, clean_data_streetcar, clean_data_subway)

#Fix some categories
combined_data <- combined_data |> mutate(
  Incident =
    case_match(
      Incident,
      "Diversion"  ~ "Diversion", 
      "Security"  ~ "Security", 
      "Cleaning - Unsanitary" ~ "Cleaning",
      "Emergency Services"  ~ "Emergency Services", 
      "Collision - TTC" ~ "Collision",
      "Mechanical" ~ "Mechanical",
      "Operations - Operator" ~ "Operations",
      "Investigation" ~ "Investigation", 
      "Utilized Off Route" ~ "Diversion",
      "General Delay" ~ "General Delay", 
      "Road Blocked - NON-TTC Collision" ~ "Collision",
      "Held By" ~ "Held By" , 
      "Vision" ~ "Vision", 
      "Operations" ~ "Operations", 
      "Collision - TTC Involved" ~ "Collision",
      "Late Entering Service" ~ "Late Entering Service", 
      "Overhead" ~ "Overhead", 
      "Rail/Switches" ~ "Rail/Switches", 
      "NA" ~ "N/A"
    )
)

combined_data

#### Save data ####
write_parquet (x = combined_data,
               sink = "data/02-analysis_data/analysis_data.parquet")
 
