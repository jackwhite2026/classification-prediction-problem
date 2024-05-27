# Classification Prediction Problem
# Analysis of trained models (comparisons)

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load in data and folds
load(here("data/folds_classification.rda"))
load(here("attempt_1/results/fit_logistic_1.rda"))
load(here("attempt_1/results/tune_en_1.rda"))

# creating individual tables 

tbl_log_1 <- show_best(fit_logistic_1, metric = "roc_auc") |> 
  slice_min(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Logistic")

tbl_en_1 <- show_best(tune_en_1, metric = "roc_auc") |> 
  slice_min(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net")

# combining tables

results_table <- bind_rows(tbl_log_1, tbl_en_1) |>
  arrange(mean)

view(results_table)

# save results table
save(results_table, file = here("attempt_1/results/results_table.rda"))