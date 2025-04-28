
data_e_s = two_afc_data %>% filter(language == "english" | language == "spanish")
library(brms)

b <- brms::brm(
  formula = response ~ step_cont * language,
    (language | participant), 
  family = "bernoulli",  
  cores = parallel::detectCores(), 
  data = data_e_s
)

# bernoulli

# Plot 3-way interaction triptych ---------------------------------------------

summary(two_afc_data$score)

# Choose settings for interaction
int_conditions_trip <- list(
  score_std = setNames(c(-1, 0, 1), c("-2", "0", "2")), 
  context_dev = setNames(c(-0.5, 0.5), c("spanish", "english"))
)


mean(two_afc_data$score) + sd(two_afc_data$score)
mean(two_afc_data$score)
mean(two_afc_data$score) - sd(two_afc_data$score)

# Select conditions for context_dev
conditions_trip <- make_conditions(b, "score") %>% 
  mutate(., cond__ = forcats::fct_recode(cond__, 
                                `z-LexTALE = -2` = "score = 69.7", 
                                `z-LexTALE = 0` = "score = 80.2", 
                                `z-LexTALE = 2` = "score = 90.8"))

# Get predictions 
three_way_trip <- conditional_effects(
  b, "step_cont:language", 
  int_conditions = int_conditions_trip,
  conditions = conditions_trip, 
  spaghetti = T, 
  nsamples = 500
)

summary(b)

conditional_effects(b)
# Generate plot
plot(three_way_trip, plot = F, 
                            line_args = list(size = 1.5))[[1]] + 
  labs(y = "Proportion /p/", x = "VOT (ms)") 
