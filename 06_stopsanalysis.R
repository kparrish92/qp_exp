# Analysis - I want the  L3 boundary /p/ or /u/ to be the dependent variable, 
# and to see whether this is predicted by the english boundary, spanish boundary, 
# L3 group, or order of acquisition. 

# I will calculate the boundaries for L1, L2 and L3. 
# The Model will be glm L3bound ~ order of acquisition, L3 group, eb, sb

# divide stops by language and group - get mean response per group. I could
# not get the cross_over function to work within the pipe/summarize

ebs = all_stops %>% 
  filter(., language == "english") %>% 
  group_by(participant) %>%
  summarise(ebs = mean(response))

sbs = all_stops %>% 
  filter(., language == "spanish") %>% 
  group_by(participant) %>%
  summarise(sbs = mean(response))

fbs = all_stops %>% 
  filter(., language == "french") %>% 
  group_by(participant) %>%
  summarise(l3bs = mean(response))

fbs = fbs %>%
  filter(!is.na(l3bs)) %>% 
  mutate(l3group = "f")

hbs = all_stops %>% 
  filter(., language == "hungarian") %>% 
  group_by(participant) %>%
  summarise(l3bs = mean(response))

hbs = hbs %>%
  filter(!is.na(l3bs)) %>% 
  mutate(l3group = "h")


l3bs = rbind(fbs,hbs)

##  Merge LHQ data with 2afc data, filter out those who did not do all tasks. 

analyze_stops = left_join(ebs, sbs, on = "participant") %>% 
  left_join(., l3bs, on = "participant") %>% 
  left_join(lhq, on = "participant") %>% 
  filter(!is.na(sbs)) %>% 
  filter(!is.na(l3bs)) %>% 
  mutate(group = if_else(l2 == "Spanish", "ES", "SE"))




## Descriptive stats of mean boundaries per group for stops

analyze_stops %>% 
  group_by(group) %>%
  summarise(mean_ebs = mean(ebs), sd_ebs = sd(ebs), mean_sbs = mean(sbs), sd(sbs), n = n())


### Filter for SE group and exclude participants who chose the same answer 90 percent of the time.

se_descreptive_s = analyze_stops %>% 
  filter(group == "SE") %>% 
  mutate(es_effect = ebs - sbs) %>%
  filter(ebs < .9)

seh_descreptive_s = analyze_stops %>% 
  filter(group == "SE") %>% 
  filter(l3group == "h") %>% 
  summarize(mean_ebv = mean(ebs), mean_sbs = mean(sbs), mean_l3bs = mean(l3bs), n = n())

sef_descreptive_s = analyze_stops %>% 
  filter(group == "SE") %>% 
  filter(l3group == "f") %>% 
  summarize(mean_ebs = mean(ebs), mean_sbs = mean(sbs), mean_l3bs = mean(l3bs), n = n())

### Filter for ES group and exclude participants who chose the same answer 90 percent of the time. 

es_descreptive_s = analyze_stops %>% 
  filter(group == "ES") %>% 
  mutate(es_effect = ebs - sbs) %>%
  filter(ebs < .9)

esh_descreptive_s = analyze_stops %>% 
  filter(group == "ES") %>% 
  filter(l3group == "h") %>% 
  summarize(mean_ebs = mean(ebs), mean_sbs = mean(sbs), mean_l3bs = mean(l3bs), n = n())

esf_descreptive_s = analyze_stops %>% 
  filter(group == "ES") %>% 
  filter(l3group == "f") %>% 
  summarize(mean_ebs = mean(ebs), mean_sbs = mean(sbs), mean_l3bs = mean(l3bs), n = n())


## paired T-test to see whether English and Spanish boundaries are significantly different. 

## In the SE group 
t.test(se_descreptive_s$ebs, se_descreptive_s$sbs, paired = TRUE)

t.test(se_descreptive_s$ebs, se_descreptive_s$l3bs, paired = TRUE)

t.test(se_descreptive_s$sbs, se_descreptive_s$l3bs, paired = TRUE)

## In the ES group
t.test(es_descreptive_s$ebs, es_descreptive_s$sbs, paired = TRUE)

t.test(es_descreptive_s$ebs, es_descreptive_s$l3bs, paired = TRUE)

t.test(es_descreptive_s$sbs, es_descreptive_s$l3bs, paired = TRUE)


## Fitting a model for stop boundaries

analyze_stops$l3group <- factor(analyze_stops$l3group)

is.factor(analyze_stops$l3group)


analyze_stops$group <- factor(analyze_stops$group)

is.factor(analyze_stops$group)


# Plot L3 boundaries by order of acquisition 
ggplot(data = analyze_stops, aes(x = group, y = l3bs, color = l3group)) + 
  geom_boxplot()

# Plot boundary per language per group 
analyze_stops %>% 
  pivot_longer(c(`ebs`, `sbs`, `l3bs`), names_to = "language", values_to = "step") %>% 
  ggplot(., aes(x = group, y = step, color = language)) + geom_boxplot()

# Plot S-shaped curves per group 

# SEH stops
analyze_stops %>%
  filter(group == "SE") %>% 
  filter(l3group == "h") %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English Hungarian stops")


# SEF stops
analyze_stops %>%
  filter(group == "SE") %>% 
  filter(l3group == "f") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English French Stops")

ttest_seh = analyze_stops %>% 
  filter(l3group == "f") %>% 
  filter(group == "SE") 

t.test(ttest_seh$l3bs, ttest_seh$ebs, paired = TRUE)

# Facet SE group by l3 group

all_stops %>%
  filter(group == "SE") %>% 
  filter(!is.na(l3group)) %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ l3group) + geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English Stops")


# ESH Stops 

all_stops %>%
  filter(group == "ES") %>% 
  filter(l3group == "h") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish Hungarian Stops")

# ESF stops 

all_stops %>%
  filter(group == "ES") %>% 
  filter(l3group == "f") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish French Stops")


# Facet ES group by l3 group

all_stops %>%
  filter(group == "ES") %>% 
  filter(!is.na(l3group)) %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ l3group) + geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish Stops")



