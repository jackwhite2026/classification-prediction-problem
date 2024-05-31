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
load(here("attempt_6/results/knn_tuned_6.rda"))

# creating individual tables 

tbl_knn_1 <- show_best(knn_tuned_6, metric = "roc_auc") |> 
  slice_min(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "KNN")

# save results table
save(knn_tuned_6, file = here("attempt_6/results/results_table_6.rda"))