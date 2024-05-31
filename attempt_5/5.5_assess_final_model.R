# Classification Prediction Problem
# load packages
library(tidyverse)
library(tidymodels)
library(here)

# load data
load(here("attempt_4/results/final_fit_4.rda"))
load(here("data/test_classification.rda"))

predicted_prob_bt_2 <- predict(final_fit_4, test_classification, type = "prob")

prob_result_bt_2 <- test_classification |>
  select(id) |>
  bind_cols(predicted_prob_bt_2) |>
  select(id, .pred_TRUE) |>
  rename(predicted = .pred_TRUE)

prob_result_bt_2

# making boosted tree submission
write_csv(prob_result_bt_2, file = here("attempt_4/submission/bt_submission_attempt_4.csv"))