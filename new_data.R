
# Coming back in 2024 

two_afc_data = read.csv(here("data", "tidy", "all_2afc.csv"))

prof_df = read.csv(here("data", "tidy", "co_df_prof.csv"))


unique(two_afc_data$language)

two_afc_data %>% 
  filter(exp == "stops") %>% 
  ggplot(aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_grid(~participant)

two_afc_data %>% 
  filter(exp == "vowels") %>% 
  ggplot(aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_wrap(~participant)


unique(two_afc_data$participant)

two_afc_data %>% 
  filter(exp == "stops") %>% 
  filter(participant == "5a08c9a7f2e3460001edb063") %>% 
  ggplot(aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_wrap(exp~participant)


stops = two_afc_data %>% 
  filter(exp == "stops") %>% 
  filter(language == "english" | language == "spanish")

mod_stops = glmer(response ~ language + (language | participant), 
                   family = binomial(link = "logit"), data = stops)


df_partial_pooling <- coef(mod_stops)[["participant"]] %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column("participant") %>% 
  as_tibble() %>% 
  rename(Intercept = `(Intercept)`)

df_partial_pooling %>% 
  ggplot(aes(x = languagespanish, y = participant)) + geom_point()
