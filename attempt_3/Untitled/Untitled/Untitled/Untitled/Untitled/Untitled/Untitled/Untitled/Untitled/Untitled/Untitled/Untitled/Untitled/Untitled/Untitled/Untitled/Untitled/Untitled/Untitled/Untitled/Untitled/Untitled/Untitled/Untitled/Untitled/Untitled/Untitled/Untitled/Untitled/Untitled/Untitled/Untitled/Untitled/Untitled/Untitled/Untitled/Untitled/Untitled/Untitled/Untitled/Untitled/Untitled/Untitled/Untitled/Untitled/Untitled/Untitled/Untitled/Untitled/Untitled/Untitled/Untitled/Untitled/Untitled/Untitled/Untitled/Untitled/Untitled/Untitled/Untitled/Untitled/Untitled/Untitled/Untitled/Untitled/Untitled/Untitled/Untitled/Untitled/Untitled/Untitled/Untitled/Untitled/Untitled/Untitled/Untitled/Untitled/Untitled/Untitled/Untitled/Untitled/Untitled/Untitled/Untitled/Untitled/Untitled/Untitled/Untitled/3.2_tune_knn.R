# Classification Prediction Problem
# KNN

## load packages ----

library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data
load(here('data/folds_classification.rda'))
load(here('attempt_3/results/classification_recipe_2.rda'))

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
wflow_knn_1 <- workflow() |> 
  add_model(knn_mod) |> 
  add_recipe(classification_recipe_2)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_mod)

# change hyperparameter ranges
knn_params <- parameters(knn_mod)

# build tuning grid
knn_grid <- grid_regular(knn_params, levels = 5)

# fit workflows/models ----
# set seed
set.seed(20243012)

# tune model
tune_knn_1 <- 
  wflow_knn_1 |> 
  tune_grid(
    folds_classification, 
    grid = knn_grid, 
    control = control_grid(save_workflow = TRUE),
    metrics = metric_set(roc_auc)
  )

# write out results (fitted/trained workflows) ----
save(wflow_knn_1, file = here("attempt_3/results/wflow_knn_1.rda"))
save(tune_knn_1, file = here("attempt_3/results/tune_knn_1.rda"))