library(ggplot2)

ggplot(data = all_vowels, aes (x = step_cont, y = resp_vowel, color = language)) + geom_smooth(method = "glm")



ggplot(data = all_vowels_se, aes (x = step_cont, y = resp_vowel, color = language)) + 
geom_smooth(method = "glm", method.args = list(family = "binomial")) + ggtitle("SE vowels")


ggplot(data = all_vowels_es, aes (x = step_cont, y = resp_vowel, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + ggtitle("ES vowels")


ggplot(data = all_stops_se, aes (x = step_cont, y = resp_stop, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + ggtitle("SE stops")


ggplot(data = all_stops_es, aes (x = step_cont, y = resp_stop, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + ggtitle("ES vowels")
