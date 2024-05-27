# Classification Prediction Problem
# load packages
library(tidyverse)
library(tidymodels)
library(here)

# load data
load(here("attempt_3/results/final_fit_3.rda"))
load(here("data/test_classification.rda"))

predicted_prob_knn_1 <-  predict(final_fit_3, test_classification, type = "prob")

prob_result_knn_1 <- test_classification |>
  select(id) |>
  bind_cols(predicted_prob_knn_1) |>
  select(id, .pred_TRUE) |>
  rename(predicted = .pred_TRUE)

prob_result_knn_1

# making boosted tree submission
write_csv(prob_result_knn_1, file = here("attempt_3/submission/knn_submission_attempt_3.csv"))