# Classification Prediction Problem
# EDA

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(patchwork)
library(naniar)
library(kableExtra)
library(corrplot)

# handle common conflicts
tidymodels_prefer()

# load data ----
train_classification <- read_csv(here("data/train_classification.csv"), col_type = cols(id = col_character()))
test_classification <- read_csv(here("data/test_classification.csv"), col_type = cols(id = col_character()))

# check missingness
missingness <- train_classification |>  miss_var_summary() 

#  data with unacceptable missingness
#-first_review, -last_review, -review_scores_cleanliness, -review_scores_communication, -reviews_per_month, 
#-review_scores_rating, -review_scores_accuracy, -review_scores_checkin, -review_scores_location, 
#-review_scores_value, -host_location, -host_neighbourhood

# checking column types
str(train_classification)
str(test_classification)

# changing column types

train_classification <- train_classification |> 
  mutate(host_response_time = as.factor(host_response_time))

test_classification <- test_classification |> 
  mutate(host_response_time = as.factor(host_response_time))

train_classification <- train_classification |> 
  mutate(host_response_rate = parse_number(host_response_rate))

test_classification <- test_classification |> 
  mutate(host_response_rate = parse_number(host_response_rate))

train_classification <- train_classification |> 
  mutate(host_acceptance_rate = parse_number(host_acceptance_rate))

test_classification <- test_classification |> 
  mutate(host_acceptance_rate = parse_number(host_acceptance_rate))

train_classification <- train_classification |> 
  mutate(property_type = as.factor(property_type))

test_classification <- test_classification |> 
  mutate(property_type = as.factor(property_type))

train_classification <- train_classification |> 
  mutate(room_type = as.factor(room_type))

test_classification <- test_classification |> 
  mutate(room_type = as.factor(room_type))

train_classification <- train_classification |> 
  mutate(bathrooms_text = as.factor(bathrooms_text))

test_classification <- test_classification |> 
  mutate(bathrooms_text = as.factor(bathrooms_text))

train_classification <- train_classification |> 
  mutate_if(is.Date, as.character)

test_classification <- test_classification |>
  mutate_if(is.Date, as.character)

train_classification <- train_classification |>
  mutate_if(is.logical, as.character)

test_classification <- test_classification |>
  mutate_if(is.logical, as.character)

train_classification <- train_classification |> 
  mutate(host_is_superhost = as.factor(host_is_superhost))

train_classification <- train_classification |> 
  mutate(host_has_profile_pic = as.factor(host_has_profile_pic))

test_classification <- test_classification |> 
  mutate(host_has_profile_pic = as.factor(host_has_profile_pic))

train_classification <- train_classification |> 
  mutate(host_identity_verified = as.factor(host_identity_verified))

test_classification <- test_classification |> 
  mutate(host_identity_verified = as.factor(host_identity_verified))

train_classification <- train_classification |> 
  mutate(has_availability = as.factor(has_availability))

test_classification <- test_classification |> 
  mutate(has_availability = as.factor(has_availability))

train_classification <- train_classification |> 
  mutate(instant_bookable = as.factor(instant_bookable))

test_classification <- test_classification |> 
  mutate(instant_bookable = as.factor(instant_bookable))


save(train_classification, file = here('data/train_classification.rda'))
save(test_classification, file = here('data/test_classification.rda'))
