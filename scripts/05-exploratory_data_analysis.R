#### Preamble ####
# Purpose: Explore the analysis data
# Author: Claire Chang
# Date: November 26 2024
# Contact: claire.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Analysis data generated in 02-analysis_data
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("/Users/claire/Downloads/Toronto_Transportation-main 2/data/02-analysis_data/cleaned_combined_data.parquet")

# Bar Plot of Delay Frequency by Transit Mode 
ggplot(analysis_data, aes(x = Transit_mode, fill = Incident)) +
  geom_bar(position = "stack") +
  labs(title = "Frequency of Delays by Transit Mode", x = "Transit Mode", y = "Number of Delays", fill = "Incident Type")

#Line Plot of Delay Frequency Over Time
ggplot(analysis_data, aes(x = Date, group = Transit_mode, color = Transit_mode)) +
  geom_line(stat = 'count') +
  labs(title = "Frequency of Delays Over Time by Transit Mode", x = "Date", y = "Number of Delays")

#Day of the Week Distribution
ggplot(analysis_data, aes(x = Day, fill = Transit_mode)) +
  geom_bar(position = "dodge") +
  labs(title = "Delays by Day of the Week and Transit Mode", x = "Day of the Week", y = "Number of Delays", fill = "Transit Mode")

#Boxplot of Delay Duration by Transit Mode
ggplot(analysis_data, aes(x = Transit_mode, y = Min Delay)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Delay Duration by Transit Mode", x = "Transit Mode", y = "Delay Duration (mins)")

#Heatmap of Delays by Time of Day and Transit Mode
ggplot(analysis_data, aes(x = Time, y = Transit_mode, fill = Min Delay)) +
  geom_tile() +
  labs(title = "Heatmap of Delay Duration by Time of Day and Transit Mode", x = "Time of Day", y = "Transit Mode", fill = "Delay Duration (mins)")




