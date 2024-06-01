# Classification Prediction Problem
# Recipes

## load packages ----

library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/train_classification.rda"))

# creating kitchen sink recipe ----
classification_recipe_2 <- recipe(host_is_superhost ~., data = train_classification) |> 
  step_rm(id) |> 
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_median(all_numeric_predictors()) |>
  step_novel(all_nominal_predictors()) |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE)

# seeing if recipe works
classification_recipe_2_check <- prep(classification_recipe_2) |>
  bake(new_data = NULL)

save(classification_recipe_2, file = here('attempt_4/results/classification_recipe_2.rda'))