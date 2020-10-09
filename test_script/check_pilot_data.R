library("tidyverse")
library("here")


temp_vowel_df <- read_csv(here("data", "em01p_2020_Oct_09_1451.csv")) %>% 
  filter(!is.na(resp_2.keys) | !is.na(resp_3.keys)) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels")) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum), 
         resp_vowel = if_else(resp_2.keys == "left", 0, 1))

temp_stops_df <- read_csv(here("data", "em01p_2020_Oct_09_1451.csv")) %>% 
  filter(!is.na(resp_3.keys)) %>% 
  mutate(exp = "stops") %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "/") %>% 
  separate(step, into = c("trash", "step2"), sep = 2) %>% 
  separate(step2, into = c("step3", "trash"), sep = 3) %>% 
  mutate(step_cont = as.numeric(step3), 
         resp_stop = if_else(resp_3.keys == "left", 1, 0))

temp_vowel_df %>% 
  filter(exp == "vowels") %>% 
  ggplot(., aes(x = step_cont, y = resp_vowel)) + 
    geom_hline(yintercept = 0.5, size = 3.2, color = "white") + 
    geom_jitter(height = 0.02, alpha = 0.3) + 
    geom_smooth(method = "glm", method.args = list(family = "binomial"), 
      formula = 'y ~ x')

temp_stops_df %>% 
  ggplot(., aes(x = step_cont, y = resp_stop)) + 
    geom_hline(yintercept = 0.5, size = 3.2, color = "white") + 
    geom_jitter(height = 0.02, alpha = 0.3) + 
    geom_smooth(method = "glm", method.args = list(family = "binomial"), 
      formula = 'y ~ x')
