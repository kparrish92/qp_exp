
# Tidy 2afc task --------------------------------------------------------------


# English data 
english = dir_ls(here("raw_data", "english_2afc"), regexp = "\\.csv$") %>%
  map_dfr(read_csv, .id = "source")



english = english %>% 
  select(stimuli, participant, date, expName, resp_2.keys, resp_3.keys) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels")) %>% 
  mutate(language = "english")

english_vowels = english %>% 
  filter(!is.na(resp_2.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum),
         resp_vowel = if_else(resp_2.keys == "left", 0, 1)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_vowel)


english_stops = english %>% 
  filter(!is.na(resp_3.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "/") %>% 
  separate(step, into = c("trash", "step2"), sep = 2) %>% 
  separate(step2, into = c("step3", "trash"), sep = 3) %>% 
  mutate(step_cont = as.numeric(step3), 
         resp_stop = if_else(resp_3.keys == "left", 1, 0)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_stop)


### Spanish Data
  
spanish <-
  list.files(path = "./raw_data/spanish_2afc",
             pattern = "*.csv", 
             full.names = T) %>% 
  map_df(~read_csv(., col_types = cols(.default = "c"))) 
  
warnings()
  
spanish = spanish %>% 
  select(stimuli, participant, date, expName, resp_2.keys, resp_3.keys) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels")) %>% 
  mutate(language = "spanish")

spanish_vowels = spanish %>% 
  filter(!is.na(resp_2.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum),
         resp_vowel = if_else(resp_2.keys == "left", 0, 1)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_vowel)


spanish_stops = spanish %>% 
  filter(!is.na(resp_3.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "/") %>% 
  separate(step, into = c("trash", "step2"), sep = 2) %>% 
  separate(step2, into = c("step3", "trash"), sep = 3) %>% 
  mutate(step_cont = as.numeric(step3), 
         resp_stop = if_else(resp_3.keys == "left", 1, 0)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_stop)




## French data 



french = dir_ls(here("raw_data", "french_2afc"), regexp = "\\.csv$") %>%
  map_dfr(read_csv, .id = "source")


french = french %>% 
  select(stimuli, participant, date, expName, resp_2.keys, resp_3.keys) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels")) %>% 
  mutate(language = "french")

french_vowels = french %>% 
  filter(!is.na(resp_2.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum),
         resp_vowel = if_else(resp_2.keys == "left", 0, 1)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_vowel)


french_stops = french %>% 
  filter(!is.na(resp_3.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "/") %>% 
  separate(step, into = c("trash", "step2"), sep = 2) %>% 
  separate(step2, into = c("step3", "trash"), sep = 3) %>% 
  mutate(step_cont = as.numeric(step3), 
         resp_stop = if_else(resp_3.keys == "left", 1, 0)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_stop)


## Hungarian data 

hungarian <-
  list.files(path = "./raw_data/hungarian_2afc",
             pattern = "*.csv", 
             full.names = T) %>% 
  map_df(~read_csv(., col_types = cols(.default = "c"))) 


hungarian = hungarian %>% 
  select(stimuli, participant, date, expName, resp_2.keys, resp_3.keys) %>% 
  mutate(exp = if_else(is.na(resp_2.keys), "stops", "vowels")) %>% 
  mutate(language = "hungarian")

hungarian_vowels = hungarian %>% 
  filter(!is.na(resp_2.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "_") %>% 
  separate(step, into = c("continuum", "trash2"), sep = 2) %>% 
  mutate(step_cont = as.numeric(continuum),
         resp_vowel = if_else(resp_2.keys == "left", 0, 1)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_vowel)


hungarian_stops = hungarian %>% 
  filter(!is.na(resp_3.keys)) %>% 
  filter(nchar(as.character(participant))==24) %>% 
  separate(stimuli, into = c("trash1", "step"), sep = "/") %>% 
  separate(step, into = c("trash", "step2"), sep = 2) %>% 
  separate(step2, into = c("step3", "trash"), sep = 3) %>% 
  mutate(step_cont = as.numeric(step3), 
         resp_stop = if_else(resp_3.keys == "left", 1, 0)) %>% 
  select(participant, date, expName, resp_2.keys, exp, language, step_cont, resp_stop)



## Combine them all 
all_stops = rbind(english_stops, hungarian_stops, spanish_stops, french_stops)
all_vowels = rbind(english_vowels, spanish_vowels, french_vowels, hungarian_vowels)









  
  

