# Classification Prediction Problem
# load packages
library(tidyverse)
library(tidymodels)
library(here)

# load data
load(here("attempt_1/results/final_fit.rda"))
load(here("data/test_classification.rda"))

predicted_prob_en_1 <-  predict(final_fit, test_classification, type = "prob")

prob_result_en_1 <- test_classification |>
  select(id) |>
  bind_cols(predicted_prob_en_1) |>
  select(id, .pred_TRUE) |>
  rename(predicted = .pred_TRUE)

prob_result_en_1

# making boosted tree submission
write_csv(prob_result_en_1, file = here("attempt_1/submission/en_submission_attempt_1.csv"))