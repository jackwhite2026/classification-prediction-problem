# Classification Prediction Problem
# load packages
library(tidyverse)
library(tidymodels)
library(here)

# load data
load(here("attempt_2/results/final_fit_2.rda"))
load(here("data/test_classification.rda"))

predicted_prob_bt_1 <-  predict(final_fit_2, test_classification, type = "prob")

prob_result_bt_1 <- test_classification |>
  select(id) |>
  bind_cols(predicted_prob_bt_1) |>
  select(id, .pred_TRUE) |>
  rename(predicted = .pred_TRUE)

prob_result_bt_1

# making boosted tree submission
write_csv(prob_result_bt_1, file = here("attempt_2/submission/bt_submission_attempt_2.csv"))