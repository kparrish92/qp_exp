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

all_stops  <- bind_rows(
  english_stops, hungarian_stops, spanish_stops, french_stops) %>% 
  write_csv(here("data", "tidy", "2afc_stops_tidy.csv"))

all_vowels <- bind_rows(
  english_vowels, spanish_vowels, french_vowels, hungarian_vowels) %>% 
  write_csv(here("data", "tidy", "2afc_vowels_tidy.csv"))

complete_2afc <- bind_rows(all_stops, all_vowels) %>% 
  write_csv(here("data", "tidy", "2afc_complete_tidy.csv"))

# -----------------------------------------------------------------------------
