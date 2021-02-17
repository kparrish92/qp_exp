# Load data -------------------------------------------------------------------
#
# Last update: 2021-02-16
# Describe what this script does here.
#
# -----------------------------------------------------------------------------




# Source libs and data --------------------------------------------------------

source(here::here("03_load_data.R"))

# -----------------------------------------------------------------------------


ggplot(data = vowels_2afc, 
  aes (x = step_cont, y = response, color = group)) + 
  facet_grid(. ~ language) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

ggplot(data = stops_2afc, 
  aes (x = step_cont, y = response, color = group)) + 
  facet_grid(. ~ language) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial"))


# NOt sure what this is (is se/es supposed to specify the group?)
ggplot(data = all_vowels_se, 
  aes(x = step_cont, y = resp_vowel, color = language)) +  
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  ggtitle("SE vowels")


ggplot(data = all_vowels_es, 
  aes(x = step_cont, y = resp_vowel, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  ggtitle("ES vowels")


ggplot(data = all_stops_se, 
  aes(x = step_cont, y = resp_stop, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  ggtitle("SE stops")


ggplot(data = all_stops_es, 
  aes(x = step_cont, y = resp_stop, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  ggtitle("ES vowels")
