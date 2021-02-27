# Analyses --------------------------------------------------------------------
#
# Last update: 2021-02-26
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs, data, and models -----------------------------------------------

source(here::here("03_load_data.R"))
log_stops_mod  <- readRDS(here("models", "log_stops_mod.rds"))
log_vowels_mod <- readRDS(here("models", "log_vowels_mod.rds"))

# -----------------------------------------------------------------------------




# Preprocessing for eLog omnibus model ----------------------------------------

elog_2afc <- all_2afc %>% 
  group_by(., participant, exp, l1, language, step_cont) %>%
  mutate(rep_n = seq_along(step_cont)) %>% 
  summarise(., n = length(unique(rep_n)), 
               resp_1 = sum(response), 
               resp_0 = n - resp_1, 
               prop = resp_1 / n, 
               eLog = log((resp_1 + 0.5) / (n - resp_1 + 0.5)), 
               wts = 1 / (resp_1 + 0.5) + 1 / (n - resp_1 + 0.5)) %>% 
  mutate(., bin = seq_along(step_cont)) %>% 
  ungroup(.) %>% 
  group_by(exp) %>% 
  mutate(step_std = (step_cont - mean(step_cont)) / sd(step_cont))

# -----------------------------------------------------------------------------




# Ominubus models -------------------------------------------------------------

if (F) {
log_stops_mod <- glmer(
  cbind(resp_1, resp_0) ~ 1 + step_std + l1 + language + 
    step_std:l1 + step_std:language + step_std:l1:language + 
    (1 + step_std + language | participant),
  control = glmerControl(optimizer = 'bobyqa'),
  data = filter(elog_2afc, exp == "stops"), 
  family = "binomial")

log_vowels_mod <- glmer(
  cbind(resp_1, resp_0) ~ 1 + step_std + l1 + language + 
    step_std:l1 + step_std:language + step_std:l1:language + 
    (1 + step_std + language | participant),
  control = glmerControl(optimizer = 'bobyqa'),
  data = filter(elog_2afc, exp == "vowels"), 
  family = "binomial")

}

summary(log_stops_mod)
summary(log_vowels_mod)

saveRDS(log_stops_mod, here("models", "log_stops_mod.rds"))
saveRDS(log_vowels_mod, here("models", "log_vowels_mod.rds"))

# -----------------------------------------------------------------------------




# Crossover analyses ----------------------------------------------------------

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
      eLog ~ step_cont, 
      weights = wts, 
      data = data 
      )
    return(mod)
  }
}

# Nest data and fit glm to every participant in every session
ind_dfs <- elog_2afc %>% 
  group_by(participant, exp, language) %>% 
  nest() %>% 
  mutate(mod = map(data, fit_one_mod, elog = FALSE)) %>% 
  mutate(tidy = map(mod, tidy))

# Clean up and calculate crossover and css
co_df <- ind_dfs %>% 
  unnest(tidy) %>% 
  select(-c('std.error', 'statistic', 'p.value')) %>% 
  pivot_wider(names_from = "term", values_from = "estimate") %>% 
  select(participant:language, intercept = `(Intercept)`, slope = step_std) %>% 
  mutate(co = intercept / slope * -1) %>% 
  left_join(., all_2afc %>% select(participant, l1, l2, group) %>% distinct, 
    by = "participant")

saveRDS(co_df, here("data", "tidy", "co_all_tidy.rds"))

# Some plots to see whats going on
p_stops <- co_df %>% 
  filter(exp == "stops") %>% 
  ggplot() + 
  aes(x = language, y = co, color = language) + 
  facet_wrap(~ l1, scales = "free_y") + 
  geom_point(alpha = 0.1) + 
  coord_cartesian(ylim = c(-4, 10)) + 
  stat_summary(fun = median, geom = "point", pch = 21, fill = "white")

p_vowels <- co_df %>% 
  filter(exp == "vowels") %>% 
  ggplot() + 
  aes(x = language, y = co, color = language) + 
  facet_wrap(~ l1, scales = "free_y") + 
  geom_point(alpha = 0.1) + 
  coord_cartesian(ylim = c(-4, 10)) + 
  stat_summary(fun = median, geom = "point", pch = 21, fill = "white")

p_stops / p_vowels








# Model predictions for plotting
log_mod_pred <- expand.grid(
  unique(elog_2afc$participant), 
  seq(from = -2,
      to = 2, 
      length.out = 120), 
  unique(elog_2afc$l1), 
  unique(elog_2afc$language)) %>%  
  rename(., participant = Var1, step_std = Var2, l1 = Var3, language = Var4) %>% 
  arrange(., participant, l1, language, step_std)

log_stops_mod_sim <- merTools::predictInterval(
  merMod = log_stops_mod, 
  newdata = log_mod_pred, 
  which = 'full', 
  level = 0.95, n.sims = 999, stat = 'mean', 
  type = 'probability', returnSims = FALSE, seed = 1)

log_vowels_mod_sim <- merTools::predictInterval(
  merMod = log_vowels_mod, 
  newdata = log_mod_pred, 
  which = 'full', 
  level = 0.95, n.sims = 999, stat = 'mean', 
  type = 'probability', returnSims = FALSE, seed = 1)

stop_preds  <- bind_cols(log_mod_pred, log_stops_mod_sim)
vowel_preds <- bind_cols(log_mod_pred, log_vowels_mod_sim)  

saveRDS(stop_preds, here("models", "model_preds_2afc_stops.rds"))
saveRDS(vowel_preds, here("models", "model_preds_2afc_vowels.rds"))

stop_preds %>% 
  ggplot(., aes(x = step_std, y = fit)) + 
    facet_grid(. ~ l1) + 
    stat_summary(aes(ymax = upr, ymin = lwr, fill = language), 
      fun.data = mean_se, geom = 'ribbon', alpha = 0.3) + 
    stat_summary(aes(y = fit, color = language), 
      fun = mean, geom = 'line', show.legend = T, size = 1.2) + 
    geom_jitter(data = filter(all_2afc, exp == "stops"), 
      aes(x = step_std, y = response), 
      alpha = 0.01, height = 0.01, width = 0.3) +
    labs(title = "Stops", y = "Predicted response", x = "VOT (ms)") + 
    scale_color_viridis_d(option = "C", end = 0.8, name = NULL) + 
    scale_fill_viridis_d(option = "C", end = 0.8, name = NULL) + 
    ds4ling::ds4ling_bw_theme(base_family = "Times", base_size = 12)

vowel_preds %>% 
  ggplot(., aes(x = step_std, y = fit)) + 
    facet_grid(. ~ l1) + 
    stat_summary(aes(ymax = upr, ymin = lwr, fill = language), 
      fun.data = mean_se, geom = 'ribbon', alpha = 0.3) + 
    stat_summary(aes(y = fit, color = language), 
      fun = mean, geom = 'line', show.legend = T, size = 1.2) + 
    geom_jitter(data = filter(all_2afc, exp == "vowels"), 
      aes(x = step_std, y = response), 
      alpha = 0.01, height = 0.01, width = 0.3) +
    labs(title = "Vowels", y = "Predicted response", x = "VOT (ms)") + 
    scale_color_viridis_d(option = "C", end = 0.8, name = NULL) + 
    scale_fill_viridis_d(option = "C", end = 0.8, name = NULL) + 
    ds4ling::ds4ling_bw_theme(base_family = "Times", base_size = 12)







