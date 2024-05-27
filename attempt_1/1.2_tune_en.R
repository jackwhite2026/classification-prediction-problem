# Classification Prodiction Problem
# Define and fit elastic net

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# load training data
load(here("data/folds_classification.rda"))
load(here("data/train_classification.rda"))

# load pre-processing/feature engineering/recipe
load(here("attempt_1/results/classification_recipe_1.rda"))

# use parallel processing
num_cores <- parallel::detectCores(logical = TRUE)
doParallel::registerDoParallel(cores = num_cores)

# Define the metric set with MAE
metrics <- metric_set(auc_roc)

# model specifications for Elastic Net ----
en_mod <- logistic_reg(penalty = tune(), mixture = tune()) |> 
  set_engine("glmnet") |> 
  set_mode("classification")

# define workflows ----
wflow_en_1 <- workflow() |> 
  add_model(en_mod) |> 
  add_recipe(classification_recipe_1)

# hyperparameter tuning values ----
# check ranges for hyperparameters
hardhat::extract_parameter_set_dials(en_mod)

# change hyperparameter ranges
enet_params <- parameters(en_mod)

# build tuning grid
enet_grid <- grid_regular(enet_params, levels = 5)

# fit workflows/models ----
# set seed
set.seed(20243012)

# tune model
tune_en_1 <- 
  wflow_en_1 |> 
  tune_grid(
    folds_classification, 
    grid = enet_grid, 
    control = control_grid(save_workflow = TRUE),
    metrics = metric_set(roc_auc)
  )

# write out results (fitted/trained workflows) ----
save(wflow_en_1, file = here("attempt_1/results/wflow_en_1.rda"))
save(tune_en_1, file = here("attempt_1/results/tune_en_1.rda"))