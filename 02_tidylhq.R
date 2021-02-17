# Tidy lhq --------------------------------------------------------------------
#
# Last update: 2021-02-16
# Describe what this script does here.
#
# -----------------------------------------------------------------------------


# Source libs -----------------------------------------------------------------

source(here::here("00_libs.R"))

# -----------------------------------------------------------------------------




# Load csvs -------------------------------------------------------------------

lhq1 <- read_csv("./raw_data/lhq/LHQ 3.0 raw result (1).csv") %>% 
  janitor::clean_names() %>% 
  select(l1 = 9, l2 = 15, participant = 1, prolific = 2)
lhq2 <- read_csv("./raw_data/lhq/LHQ 3.0 raw result (2).csv") %>% 
  janitor::clean_names() %>% 
  select(l1 = 9, l2 = 15, participant = 1, prolific = 2)
lhq3 <- read_csv("./raw_data/lhq/LHQ 3.0 raw result (3).csv") %>% 
  janitor::clean_names() %>% 
  select(l1 = 9, l2 = 15, participant = 1, prolific = 2)
lhq5 <- read_csv("./raw_data/lhq/LHQ 3.0 raw result (5).csv") %>% 
  janitor::clean_names() %>% 
  select(l1 = 9, l2 = 15, participant = 1, prolific = 2)

lhq <- bind_rows(lhq1, lhq2, lhq3, lhq5)

all_stops <- read_csv(here("data", "tidy", "2afc_stops_tidy.csv")) %>% 
  left_join(., lhq, by = "participant") %>% 
  mutate(group = if_else(L2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group)) 

all_vowels <- read_csv(here("data", "tidy", "2afc_vowels_tidy.csv")) %>% 
  left_join(., lhq, by = "participant") %>% 
  mutate(group = if_else(L2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group))



# WHy do you need all these subsets?
all_vowels_se <- all_vowels %>% 
  filter(group == "SE")

all_stops_se <- all_stops %>% 
  filter(group == "SE")

all_vowels_es <- all_vowels %>% 
  filter(group == "ES")

all_stops_es <- all_stops %>% 
  filter(group == "ES")
