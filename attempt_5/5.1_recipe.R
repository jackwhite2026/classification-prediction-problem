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

 
 
 host_neighbourhood,


# creating kitchen sink recipe ----
classification_recipe_3 <- recipe(host_is_superhost ~., data = train_classification) |> 
  step_rm(first_review, last_review, reviews_per_month, review_scores_rating,
          review_scores_accuracy, review_scores_cleanliness, review_scores_checkin,
          review_scores_communication, review_scores_location, review_scores_value,
          host_location, id, host_since) |> 
  # getting rid of all the variables that have more than 10% missingness
  # getting rid of id and date variables
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_median(all_numeric_predictors()) |>
  step_novel(all_nominal_predictors()) |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE) 

# seeing if recipe works
classification_recipe_3_check <- prep(classification_recipe_3) |>
  bake(new_data = NULL)

save(classification_recipe_3, file = here('attempt_5/results/classification_recipe_3.rda'))