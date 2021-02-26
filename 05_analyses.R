# Analyses --------------------------------------------------------------------
#
# Last update: 2021-02-26
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs and data --------------------------------------------------------

source(here::here("03_load_data.R"))

# -----------------------------------------------------------------------------



# Fit omnibus model

if (F) {
full_mod <- glmer(
  response ~ step_cont + group + exp + step_cont:group + 
    (1|participant), 
  family = binomial(link = "logit"), 
  data = all_2afc)
}

# Crossover analyses ----------------------------------------------------------

# Create function to fit many models
fit_one_glm_mod <- function(data) {
    mod <- glm(
      response ~ step_cont, 
      data = data, 
      family = binomial(link = "logit")
      )
    return(mod)
}

# Nest data and fit glm to every participant in every session
ind_dfs <- all_2afc %>% 
  group_by(participant, exp, language) %>% 
  nest() %>% 
  mutate(mod = map(data, fit_one_glm_mod)) %>% 
  mutate(tidy = map(mod, tidy), 
         n = map(data, nrow) %>% simplify())

# Clean up and calculate crossover and css
co_df <- ind_dfs %>% 
  unnest(tidy) %>% 
  select(-c('std.error', 'statistic', 'p.value')) %>% 
  pivot_wider(names_from = "term", values_from = "estimate") %>% 
  select(participant:language, intercept = `(Intercept)`, slope = step_cont) %>% 
  mutate(co = intercept / slope * -1) %>% 
  left_join(., all_2afc %>% select(participant, l1, l2, group) %>% distinct, 
    by = "participant") %>% 
  saveRDS(., here("data", "tidy", "co_all_tidy.rds"))


# Some plots to see whats going on
p_stops <- co_df %>% 
  filter(exp == "stops", co <= 50 & co >= -50) %>% 
  ggplot() + 
  aes(x = language, y = co, color = language) + 
  facet_wrap(~ l1, scales = "free_y") + 
  geom_point(alpha = 0.1) + 
  stat_summary(fun.data = mean_se, geom = "pointrange")

p_vowels <- co_df %>% 
  filter(exp == "vowels", co <= 50 & co >= -50) %>% 
  ggplot() + 
  aes(x = language, y = co, color = language) + 
  facet_wrap(~ l1, scales = "free_y") + 
  geom_point(alpha = 0.1) + 
  stat_summary(fun.data = mean_se, geom = "pointrange")

p_stops / p_vowels

