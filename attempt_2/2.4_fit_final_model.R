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
load(here("attempt_2/results/btree_tuned_1.rda"))
load(here("data/train_classification.rda"))

# parallel processing
num_cores <- parallel::detectCores(logical = TRUE)
doParallel::registerDoParallel(cores = num_cores)

# best model
# train whole training set on this model
# finalize workflow ----
final_wflow_2 <-btree_tuned_1 |> 
  extract_workflow(tbtree_tuned_1) |>  
  finalize_workflow(select_best(btree_tuned_1, metric = "roc_auc"))

# train final model ----
# set seed
set.seed(20243012)
final_fit_2 <- fit(final_wflow, train_classification)

# save results
save(final_fit_2, file = "attempt_2/results/final_fit_2.rda")
save(final_wflow_2, file = "attempt_2/results/final_wflow_2.rda")