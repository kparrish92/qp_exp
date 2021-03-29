# Analyses --------------------------------------------------------------------
#
# Last update: 2021-03-27
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs, data, and models -----------------------------------------------

source(here::here("03_load_data.R"))

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




# Check crossover and do pairwise comparisons

# Remove people who response over 80% /b/ or 80% /p/
en_stops_remove <- c(
  "5fa0bf0afbd42f13cf56e987",
  "5f4056738318181904984b01",
  "5f174566f589920a8ba7e2df",
  "5b67bffa9ed653000189ff3c",
  "5f5f5013f947f6000bd8ddcb" )

fr_stops_remove <- c(
  "5b67bffa9ed653000189ff3c",
  "5ef34cc943115906d6aa397f",
  "5d3df88c6a5b1e0001a91d8d",
  "5fa0bf0afbd42f13cf56e987" )

sp_stops_remove <- c(
  "5e9546ebbc08e21354f19f4d", 
  "5d3df88c6a5b1e0001a91d8d", 
  "5ef34cc943115906d6aa397f", 
  "5b67bffa9ed653000189ff3c", 
  "5cf83992bab656000198a9c6", 
  "5fad49057daf5f0162284e86", 
  "5dab79a5525a7600139cd31e")

hu_stops_remove <- c(
  "5f174566f589920a8ba7e2df"
)

# Some plots to see whats going on
co_df %>% 
  filter(
    exp == "stops", 
    !(language == "english" & participant %in% en_stops_remove), 
    !(language == "french" & participant %in% fr_stops_remove), 
    !(language == "spanish" & participant %in% sp_stops_remove), 
    !(language == "hungarian" & participant %in% hu_stops_remove)
  ) %>% 
  ggplot() + 
  aes(x = l1, y = co, color = language) + 
  geom_point(position = position_dodge(0.5), size = 3, alpha = 0.2) + 
  stat_summary(fun.data = mean_sdl, geom = "pointrange", pch = 21, 
    fill = "white", position = position_dodge(0.5), size = 1.2, 
    fun.args = list(mult = 1)) + 
  scale_color_brewer(palette = "Set2", name = "Language mode") +
  labs(x = "L1")



co_df %>% 
  filter(
    exp == "vowels", co > -10, 
  ) %>% 
  ggplot() + 
  aes(x = l1, y = co, color = language) + 
  geom_point(position = position_dodge(0.5), size = 3, alpha = 0.2) + 
  stat_summary(fun.data = mean_sdl, geom = "pointrange", pch = 21, 
    fill = "white", position = position_dodge(0.5), size = 1.2, 
    fun.args = list(mult = 1)) + 
  scale_color_brewer(palette = "Set2", name = "Language mode") +
  labs(x = "L1")

# -----------------------------------------------------------------------------













# RQ0 -------------------------------------------------------------------------
#
# Can you replicate the double phonemic boundary effect in L2 learners using 
# conceptual cueing? Can you extend it to vowels?

en_sp_2afc <- all_2afc_long %>% 
  filter(language %in% c("english", "spanish"))

vowels_remove <- c(
  "5ec5a561c1172f5f55cfb425", 
  "5ee579ecd4169f2bee94041e", 
  "5f3020ed291f7344af6d82e1", 
  "5f641323fc170219bf367bb9"
)

#
# Vowel plots
#

# By participant
en_sp_2afc %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>% 
  ggplot(., aes(x = step_std, y = response, color = language)) + 
    facet_wrap(~ participant) + 
    geom_smooth(method = glm, method.args = list(family = "binomial"))

# All
en_sp_2afc %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>% 
  ggplot(., aes(x = step_std, y = response, lty = language, color = l1)) + 
    geom_smooth(method = glm, method.args = list(family = "binomial"))


#
# Stops
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
  "5f174566f589920a8ba7e2df"
)

# By participant
en_sp_2afc %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>% 
  ggplot(., aes(x = step_std, y = response, color = language)) + 
    facet_wrap(~ participant) + 
    geom_smooth(method = glm, method.args = list(family = "binomial"))

# All
en_sp_2afc %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>% 
  ggplot(., aes(x = step_std, y = response, lty = language, color = l1)) + 
    geom_smooth(method = glm, method.args = list(family = "binomial"))

co_df

# -----------------------------------------------------------------------------








# Q1 --------------------------------------------------------------------------
#
# Which boundary will we observe in a “third language?” 
#
# If participants are told they are hearing French, we should observe a 
# Spanish-like boundary 
#
# If particpants are told they are hearing Hungarian, we should observe a 
# boundary similar to their L2 

en_sp_2afc <- all_2afc_long %>% 
  filter(language %in% c("english", "spanish"))




# -----------------------------------------------------------------------------










# RQ2 -------------------------------------------------------------------------
#
# Will perceptual categorization of "Hungarian" and "French" result in 
# different "language specific" categorization?
#
# Spanish-English bilinguals who believe that they are hearing a romance L3 
# should have more Spanish-like boundaries




# -----------------------------------------------------------------------------
