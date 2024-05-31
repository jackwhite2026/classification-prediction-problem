# Classification Prediction Problem
# load packages
library(tidyverse)
library(tidymodels)
library(here)

# load data
load(here("attempt_6/results/final_fit_6.rda"))
load(here("data/test_classification.rda"))

predicted_prob_knn_6 <-  predict(final_fit_6, test_classification, type = "prob")

prob_result_knn_6 <- test_classification |>
  select(id) |>
  bind_cols(predicted_prob_knn_6) |>
  select(id, .pred_TRUE) |>
  rename(predicted = .pred_TRUE)

# making boosted tree submission
write_csv(prob_result_knn_6, file = here("attempt_6/submission/knn_submission_attempt_6.csv"))