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
load(here("attempt_3/results/tune_knn_1.rda"))

# creating individual tables 

tbl_knn_1 <- show_best(tune_knn_1, metric = "roc_auc") |> 
  slice_min(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree")

# save results table
save(tune_knn_1, file = here("attempt_3/results/results_table.rda"))