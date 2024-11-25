# Toronto TTC Transportation 

## Overview

This research investigates the frequency and duration of delays across different TTC (Toronto Transit Commission) transit modes—subway, streetcar, and bus. The goal is to determine which transit mode experiences the highest frequency and longest duration of delays and to understand how these delays vary by time of day. The analysis utilizes data obtained from Open Data Toronto, focusing on delay reports across TTC transit modes. By conducting a comparative analysis, this study aims to provide insights into how the reliability of TTC services fluctuates based on transit type and time of operation. This can be useful for both commuters looking to optimize their routes and for urban planners seeking to improve Toronto's public transit system.

## File Structure

The repo is structured as:

-   `00-simulated_data/`: Contains the simulated data generated for model testing.
    - `simulated_data.csv`
-   `01-data/raw_data` contains the raw data as obtained from opendatatoronto.
    - `raw_data_bus.csv`
    - `raw_data_streetcar.csv`
    - `raw_data_subway.csv`
-   `02-data/analysis_data` contains the cleaned dataset that was constructed.
    -`analysis_data.parquet`
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, test simulate, download, clean data, test analysis, EDA, model, and replications.


## Statement on LLM usage

Aspects of the code were written with the assistance of ChatGPT-4o. The entire chat history is saved in other/llm_usage/usage.txt.
