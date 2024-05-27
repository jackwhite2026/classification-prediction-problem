# Classification Prediction Problem
# Initial Setup

# Initial data checks & data splitting

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
load(here('data/train_classification.rda'))
load(here("data/test_classification.rda"))


# setting a seed ----

set.seed(12468)

# set up controls for fitting resamples ----
folds_classification <- vfold_cv(train_classification, v = 5, repeats = 3,
                             strata = host_is_superhost)

# write out split, train, test and folds ----
save(folds_classification, file = here("data/folds_classification.rda"))