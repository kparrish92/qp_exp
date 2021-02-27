# Tidy 2afc task --------------------------------------------------------------
#
# Last update: 2021-02-15
# Describe what this script does here.
#
# -----------------------------------------------------------------------------


# Source libs -----------------------------------------------------------------

source(here::here("00_libs.R"))

# -----------------------------------------------------------------------------




# Helper functions ------------------------------------------------------------

# This is the tidying pipeline that you essentially repeat for every 
# language dataset. 
# Since you are going to be repeating it over and over again, it makes 
# sense to turn it into a function. 

tidy_2afc <- . %>% 
  map_dfr(read_csv, .id = "source", col_types = cols(.default = "c")) %>% 
  select(step_cont = stimuli, participant, date, expName, resp_2.keys, resp_3.keys) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels"), 
         step_cont = str_remove(step_cont, "stim/VC_"), 
         step_cont = str_remove(step_cont, "stim2/pa"), 
         step_cont = str_remove(step_cont, "\\+"), 
         step_cont = str_remove(step_cont, ".wav"), 
         step_cont = as.numeric(step_cont), 
         response = case_when(
           resp_2.keys == "left"  ~ 0, 
           resp_2.keys == "right" ~ 1, 
           resp_3.keys == "left"  ~ 1, 
           resp_3.keys == "right" ~ 0)) %>% 
  filter(nchar(as.character(participant)) == 24)

# -----------------------------------------------------------------------------




# Tidy English data -----------------------------------------------------------

english <- dir_ls(here("raw_data", "english_2afc"), regexp = "\\.csv$") %>%
  tidy_2afc() %>% 
  mutate(language = "english")

english_vowels <- english %>% 
  filter(!is.na(resp_2.keys)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, 
         step_cont, response)

english_stops <- english %>% 
  filter(!is.na(resp_3.keys)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, 
         step_cont, response)

# -----------------------------------------------------------------------------



# Tidy Spanish Data -----------------------------------------------------------

spanish <- dir_ls(here("raw_data", "spanish_2afc"), regexp = "\\.csv$") %>% 
  tidy_2afc() %>% 
  mutate(language = "spanish")

spanish_vowels <- spanish %>% 
  filter(!is.na(resp_2.keys)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, 
         step_cont, response)

spanish_stops <- spanish %>% 
  filter(!is.na(resp_3.keys)) %>% 
  select(participant, date, expName, resp_3.keys, exp, language, 
         step_cont, response)

# -----------------------------------------------------------------------------




## Tidy French data -----------------------------------------------------------

french <- dir_ls(here("raw_data", "french_2afc"), regexp = "\\.csv$") %>%
  tidy_2afc() %>% 
  mutate(language = "french")

french_vowels <- french %>% 
  filter(!is.na(resp_2.keys)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, 
         step_cont, response)

french_stops <- french %>% 
  filter(!is.na(resp_3.keys)) %>% 
  select(participant, date, expName, resp_3.keys, exp, language, 
         step_cont, response)

# -----------------------------------------------------------------------------




# Tidy Hungarian data ---------------------------------------------------------

hungarian <- dir_ls(here("raw_data", "hungarian_2afc"), regexp = "\\.csv$") %>% 
  tidy_2afc() %>% 
  mutate(language = "hungarian") 

hungarian_vowels <- hungarian %>% 
  filter(!is.na(resp_2.keys)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, 
         step_cont, response)

hungarian_stops <- hungarian %>% 
  filter(!is.na(resp_3.keys)) %>% 
  select(participant, date, expName, resp_3.keys, exp, language, 
         step_cont, response)

# -----------------------------------------------------------------------------




# Combine data ----------------------------------------------------------------

# Add missing participant labels
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
lhq6 <- read_csv("./raw_data/lhq/LHQ 3.0 raw result (6).csv") %>% 
  janitor::clean_names() %>% 
  select(l1 = 9, l2 = 15, participant = 1, prolific = 2)

lhq <- bind_rows(lhq1, lhq2, lhq3, lhq5,lhq6)

missing_ids <- read_csv("./raw_data/lhq/prolifictolhq.csv")

lhq_sub = lhq %>% 
  filter(nchar(as.character(participant)) == 5)

lhq_main = lhq %>% 
  filter(nchar(as.character(participant)) == 24)

missing_ids = missing_ids %>% 
  janitor::clean_names() %>% 
  select(participant = 2, prolific_id = 1) %>% 
  left_join(., lhq_sub, by = "participant") %>% 
  select(l1, l2, participant, prolific_id) %>% 
  select(l1 = 1, l2 = 2, participant = 3 ,prolific = 4)


lhq = lhq_main %>% 
  rbind(., missing_ids) %>%
  filter(nchar(as.character(prolific)) == 24) %>% 
  select(l1 = 1, l2 = 2, prolific = 3, participant = 4)
  

all_stops <- bind_rows(
  english_stops, hungarian_stops, spanish_stops, french_stops) %>% 
  left_join(., lhq, by = "participant") %>% 
  mutate(group = if_else(l2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group)) %>% 
  write_csv(here("data", "tidy", "2afc_stops_tidy.csv"))

all_vowels <- bind_rows(
  english_vowels, spanish_vowels, french_vowels, hungarian_vowels) %>% 
  left_join(., lhq, by = "participant") %>% 
  mutate(group = if_else(l2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group)) %>% 
  write_csv(here("data", "tidy", "2afc_vowels_tidy.csv"))

#
# Code from here to 203 creates errors (dataframe with 2million observations)
#

assign_group_vowels = all_vowels %>%
  filter(language == "french" | language == "hungarian") %>%
  mutate(l3group = if_else(language == "french", "f", "h")) %>% 
  select(participant, l3group)

assign_group_stops = all_stops %>%
  filter(language == "french" | language == "hungarian") %>%
  mutate(l3group = if_else(language == "french", "f", "h")) %>% 
  select(participant, l3group)

all_vowels = all_vowels %>% 
  
  left_join(., assign_group_vowels, by = "participant") 

all_stops = all_stops %>% 
  left_join(., assign_group_stops, by = "participant")

#
# End of problematic code
#

complete_2afc <- bind_rows(all_stops, all_vowels) %>% 
  group_by(exp) %>% 
  mutate(step_std = (step_cont - mean(step_cont)) / sd(step_cont)) %>% 
  write_csv(here("data", "tidy", "2afc_complete_tidy.csv"))

# -----------------------------------------------------------------------------



