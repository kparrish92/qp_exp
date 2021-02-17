# Load data -------------------------------------------------------------------
#
# Last update: 2021-02-16
# Describe what this script does here.
#
# -----------------------------------------------------------------------------


# Source libs -----------------------------------------------------------------

source(here::here("00_libs.R"))

# -----------------------------------------------------------------------------

all_2afc    <- read_csv(here("data", "tidy", "2afc_complete_tidy.csv"))
stops_2afc  <- read_csv(here("data", "tidy", "2afc_stops_tidy.csv"))
vowels_2afc <- read_csv(here("data", "tidy", "2afc_vowels_tidy.csv"))
