# Cross over -------------------------------------------------------------------
#
# Last update: 2021-03-27
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs, data, and models -----------------------------------------------

source(here::here("scripts", "00_libs.R"))
source(here("scripts", "01_tidy2afc.R"))
source(here("scripts", "02_load_data.R"))

# -----------------------------------------------------------------------------




# Crossover extraction --------------------------------------------------------

# Create function to fit many models
fit_one_mod <- function(data, elog = FALSE) {
  if (elog == FALSE) {
    mod <- glm(
      cbind(resp_1, resp_0) ~ step_std, 
      data = data, 
      family = binomial(link = "logit")
    )
    return(mod)
  } else {
    mod <- lm(
      eLog ~ step_std, 
      weights = wts, 
      data = data 
    )
    return(mod)
  }
}

# Nest data and fit glm to every participant in every session
# Generates warnings because some participants have flat sigmoids
ind_dfs <- all_2afc_wide %>% 
  group_by(participant, exp, language) %>% 
  nest() %>% 
  mutate(mod = map(data, fit_one_mod, elog = FALSE)) %>% 
  mutate(tidy = map(mod, tidy))

# Clean up and calculate crossovers
co_df <- ind_dfs %>% 
  unnest(tidy) %>% 
  select(-c('std.error', 'statistic', 'p.value')) %>% 
  pivot_wider(names_from = "term", values_from = "estimate") %>% 
  select(participant:language, intercept = `(Intercept)`, slope = step_std) %>% 
  mutate(co = intercept / slope * -1) %>% 
  left_join(., all_2afc_wide %>% select(participant, l1) %>% distinct, 
            by = "participant") %>% 
  ungroup()

saveRDS(co_df, here("data", "tidy", "co_all_tidy.rds"))

# -----------------------------------------------------------------------------




