# Load data -------------------------------------------------------------------
#
# Last update: 2021-02-16
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs and data --------------------------------------------------------
source(here::here("scripts", "00_libs.R"))
source(here("scripts", "01_tidy2afc.R"))
source(here("scripts", "02_load_data.R"))
source(here("scripts", "03_crossover.R"))
source(here("scripts", "04_tidy_lextale.R"))
source(here("scripts", "05_analyses.R"))


# -----------------------------------------------------------------------------


p1 <- ggplot(data = spanl1_stops, 
  aes (x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ participant) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "Vowels")

p2 <- ggplot(data = stops_2afc, 
  aes (x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ group) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "Stops")

p1 / p2


spanl1_vowels %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  pivot_longer(c(`l1`, `l2`, `l3`), names_to = "language", values_to = "co") %>% 
  ggplot(., aes(x = language, y = co)) + 
  geom_point(position = position_dodge(0.5), size = 3, alpha = 0.2) + 
  stat_summary(fun.data = mean_sdl, geom = "pointrange", pch = 21, 
               fill = "white", position = position_dodge(0.5), size = 1.2, 
               fun.args = list(mult = 1)) + 
  scale_color_brewer(palette = "Set2", name = "Language mode") +
  labs(x = "L1")


# stops all participants 

all_data %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_wrap(. ~ participant)




## all 4 languages with stops 

all_data %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_grid(. ~ l1)


## all 4 languages with vowels 

all_data %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_grid(. ~ l1)


## just english and spanish 


# vowels 

all_data %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>% 
  filter(language == "english"| language == "spanish") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_grid(. ~ l1) + ylab("Proportion /u/") + xlab("Continuum Step") + 
  ggtitle("Figure 1") 


# stops

all_data %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>% 
  filter(language == "english"| language == "spanish") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_grid(. ~ l1)  + ylab("Proportion /p/") + xlab("Voice Onset Timte")

spanl1_vowels %>% 
  mutate(L2_L3diff = l2 - l1, L1_L3diff = l3 - l1) %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  pivot_longer(c(`L1_L3diff`, `L2_L3diff`), names_to = "difference", values_to = "degree") %>% 
  ggplot(aes(x = difference, y = degree)) + geom_boxplot()
