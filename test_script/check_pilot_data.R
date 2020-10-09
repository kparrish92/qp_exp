library("tidyverse")
library("here")


temp_df <- read_csv(here("data", "em01p_2020_Oct_09_1451.csv")) %>% 
  filter(!is.na(resp_2.keys) | !is.na(resp_3.keys)) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "vowels", "stops")) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum), 
         resp = if_else(resp_2.keys == "left", 0, 1))

glimpse(temp_df)

temp_df %>% 
  filter(exp == "stops") %>% 
  ggplot(., aes(x = step_cont, y = resp)) + 
    geom_hline(yintercept = 0.5, size = 3.2, color = "white") + 
    geom_jitter(height = 0.02, alpha = 0.3) + 
    geom_smooth(method = "glm", method.args = list(family = "binomial"), 
      formula = 'y ~ x')
