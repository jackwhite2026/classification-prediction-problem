# Classification Prediction Problem
# Train final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(doParallel)

# handle common conflicts
tidymodels_prefer()

# load necessary data ----
load(here("attempt_6/results/knn_tuned_6.rda"))
load(here("data/train_classification.rda"))

# parallel processing
num_cores <- parallel::detectCores(logical = TRUE)
doParallel::registerDoParallel(cores = num_cores)

# best model
# train whole training set on this model
# finalize workflow ----
final_wflow_6 <- knn_tuned_6 |> 
  extract_workflow(knn_tuned_6) |>  
  finalize_workflow(select_best(knn_tuned_6, metric = "roc_auc"))

# train final model ----
# set seed
set.seed(20243012)
final_fit_6 <- fit(final_wflow_6, train_classification)

# save results
save(final_fit_6, file = "attempt_6/results/final_fit_6.rda")
save(final_wflow_6, file = "attempt_6/results/final_wflow_6.rda")