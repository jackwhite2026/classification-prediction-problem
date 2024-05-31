# Classification Prediction Problem
# KNN

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load folds data
load(here("data/folds_classification.rda"))

# load pre-processing/feature engineering/recipe
load(here("attempt_6/results/classification_recipe_2.rda"))

# parallel processing
num_cores <- parallel::detectCores(logical = TRUE)
doParallel::registerDoParallel(cores = num_cores)

# set seed
set.seed(1234)

# model specifications ----
knn_mod <- nearest_neighbor(neighbors = tune()) |> 
  set_engine("kknn") |> 
  set_mode("classification")

# define workflows ----
knn_wflow_6 <- workflow() |> 
  add_model(knn_mod) |> 
  add_recipe(classification_recipe_2)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_mod)

# change hyperparameter ranges
knn_params <- parameters(knn_mod)

# build tuning grid
knn_grid_6 <- grid_latin_hypercube(knn_params, size = 50)

# fit workflows/models ----
# set seed
set.seed(1234)

# tune model
knn_tuned_6 <- 
  knn_wflow_6 |> 
  tune_grid(
    folds_classification, 
    grid = knn_grid_6, 
    control = stacks::control_stack_grid(),
    metrics = metric_set(roc_auc)
  )

# looking at results
knn_results_6 <- knn_tuned_6 |> 
  collect_metrics()

# write out results (fitted/trained workflows) ----
save(knn_wflow_6, file = here("attempt_6/results/knn_wflow_6.rda"))
save(knn_tuned_6, file = here("attempt_6/results/knn_tuned_6.rda"))
save(knn_results_6, file = here("attempt_6/results/knn_results_6.rda"))
