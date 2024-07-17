# Tidy lextale -------------------------------------------------------------------
#
# Last update: 2021-03-27
# Describe what this script does here.
#
# -----------------------------------------------------------------------------



all_data = read.csv(here("data", "tidy", "all_2afc.csv"))

co_df = readRDS(here("data", "tidy", "co_all_tidy.rds"))


# 
stops_remove <- c(
  "5b67bffa9ed653000189ff3c", 
  "5c8be0dd542fbd0016924f5f", 
  "5cf83992bab656000198a9c6", 
  "5dab79a5525a7600139cd31e", 
  "5ed39d114858d002a0691781", 
  "5ef34cc943115906d6aa397f", 
  "5f4056738318181904984b01", 
  "5f5f5013f947f6000bd8ddcb", 
  "5fa0bf0afbd42f13cf56e987", 
  "5f174566f589920a8ba7e2df",
  "5e9546ebbc08e21354f19f4d",
  "5d3df88c6a5b1e0001a91d8d",
  "5f3344917a7a0b159bd0c375",
  "5fad49057daf5f0162284e86"
)

#

vowels_remove <- c(
  "5ec5a561c1172f5f55cfb425", 
  "5ee579ecd4169f2bee94041e", 
  "5f3020ed291f7344af6d82e1", 
  "5f641323fc170219bf367bb9",
  "5fa379c756d0fe67b022823b"
)



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
  dplyr::select(participant, lextale_avg) %>% 
  rename(score = lextale_avg) 

all_lextale = rbind(spanish_bind, english_lextale)

spanish_bind2 = spanish_bind %>% 
  mutate(L1 = "English")



desc_prof = read.csv(here("data", "tidy", "co_df_prof.csv")) %>% 
  filter(!(participant %in% vowels_remove)) %>%
  filter(!(participant %in% stops_remove)) %>%
  dplyr::select(l1, score, participant) %>% 
  .[!duplicated(desc_prof$participant), ] %>% 
  group_by(l1) %>% 
  summarise(`Mean lexTALE Score` = mean(score), `SD` = sd(score), n = n())


desc_prof %>% 
  write.csv(here("data", "tidy", "desc_prof.csv"))

desc_prof_plot = read.csv(here("data", "tidy", "co_df_prof.csv")) %>% 
  filter(!(participant %in% vowels_remove)) %>%
  filter(!(participant %in% stops_remove)) %>%
  dplyr::select(l1, score, participant) %>% 
  filter(score > 60) %>% 
  .[!duplicated(desc_prof_plot$participant), ] 
  
desc_prof_plot %>% 
  write.csv(here("data", "tidy", "desc_prof_plot.csv"))



# join lextale data from both langauges with co_df

co_df_prof = co_df %>% 
  left_join(all_lextale, by = "participant") %>% 
  write_csv(here("data", "tidy", "co_df_prof.csv"))
 

