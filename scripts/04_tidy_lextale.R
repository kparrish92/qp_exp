# Tidy lextale -------------------------------------------------------------------
#
# Last update: 2021-03-27
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs, data, and models -----------------------------------------------

source(here::here("scripts", "00_libs.R"))
source(here("scripts", "01_tidy2afc.R"))
source(here("scripts", "02_load_data.R"))
source(here("scripts", "03_crossover.R"))

# -----------------------------------------------------------------------------

score_lextale <- function(
  n_real = NULL, 
  n_nonse = NULL, 
  n_real_correct = NULL, 
  n_nonse_correct = NULL, 
  n_nonse_incorrect = NULL) {
  
  if (is.null(n_nonse_incorrect)) {
    avg_real <-  (n_real_correct / n_real * 100)
    avg_nonse <- (n_nonse_correct / n_nonse * 100)
    val <- (avg_real + avg_nonse) / 2
  } else {
    val <- n_real_correct - (2 * n_nonse_incorrect)
  }
  return(val)
}


# Load english lextale data
english_lextale <- read_csv(here("data", "raw", "lextale_english.csv"))


# Load and tidy spanish lextale data 
lextale_spanish_raw = dir_ls(here("data/raw", "lextale"), regexp = "\\.csv$") %>% 
  map_dfr(read_csv, .id = "source", col_types = cols(.default = "c")) %>% 
  filter(!is.na(key_resp_lextale_trial.keys)) %>%
  mutate(., response = `key_resp_lextale_trial.keys`, 
         is_correct = key_resp_lextale_trial.corr,
         is_incorrect = if_else(is_correct == 0, 1, 0),
         is_real = case_when(
           response == 1 & is_correct == 1 ~ "real",
           response == 1 & is_correct == 0 ~ "nonse",
           response == 0 & is_correct == 1 ~ "nonse",
           response == 0 & is_correct == 0 ~ "real"),
         real_correct    = if_else(is_real == "real"  & is_correct == 1, 1, 0), 
         real_incorrect  = if_else(is_real == "real"  & is_correct == 0, 1, 0), 
         nonse_correct   = if_else(is_real == "nonse" & is_correct == 1, 1, 0), 
         nonse_incorrect = if_else(is_real == "nonse" & is_correct == 0, 1, 0))
# calculate scores, both traditional and new - remove any duplicates - filter 
# for prolific participants only 

spanish_lextale = lextale_spanish_raw %>% 
  group_by(participant, date) %>% 
  summarize(totals = n(), 
          real_correct = sum(real_correct), 
          real_incorrect = sum(real_incorrect), 
          nonse_correct = sum(nonse_correct), 
          nonse_incorrect = sum(nonse_incorrect)) %>% 
  mutate(n_real = real_correct + real_incorrect, 
         n_nonse = nonse_correct + nonse_incorrect,
         n = n_real + n_nonse, 
         lextale_avg = score_lextale(
           n_real = n_real, 
           n_nonse = n_nonse,
           n_real_correct = real_correct, 
           n_nonse_correct = nonse_correct),
         lextale_tra = score_lextale(
           n_real_correct = real_correct,
           n_nonse_incorrect = nonse_incorrect))

spanish_lextale = spanish_lextale %>% 
  .[!duplicated(spanish_lextale$participant), ]
  
spanish_bind = spanish_lextale %>%   
  filter(nchar(as.character(participant)) == 24) %>% 
  select(participant, lextale_avg) %>% 
  rename(score = lextale_avg) 

all_lextale = rbind(spanish_bind, english_lextale)

spanish_bind2 = spanish_bind %>% 
  mutate(L1 = "English")

desc_prof = english_lextale %>% 
  mutate(L1 = "Spanish") %>%
  rbind(spanish_bind2) %>% 
  filter((participant %in% all_data$participant)) %>% 
  group_by(L1) %>% 
  summarise(`Mean LEXtale Score` = mean(score), `SD` = sd(score), n = n())

desc_prof_plot = english_lextale %>% 
  mutate(L1 = "Spanish") %>%
  rbind(spanish_bind2) %>% 
  filter((participant %in% all_data$participant)) %>% 
  filter(score > 60)

# join lextale data from both langauges with co_df

co_df_prof = co_df %>% 
  left_join(all_lextale, by = "participant") %>% 
  write_csv(here("data", "tidy", "co_df_prof.csv"))
 

