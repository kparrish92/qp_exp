## Write function 

cross_over <- function(mod, cont_pred, grouping_var = FALSE, 
                       int_adj, slope_adj) {
  
  if (class(mod)[1] == "glm") {
    
    # Store intercept
    int <- summary(mod)$coefficients['(Intercept)', 'Estimate']
    
    # Store continuous x var
    slope <- summary(mod)$coefficients[cont_pred, 'Estimate']
    
    # For bivariate models
    if (grouping_var == FALSE) {
      
      # Calculate crossover
      co <- int / slope * -1
      
      # For models with grouping vars
    } else {
      
      # Calculate group level intercept
      int_derived <- int + summary(mod)$coefficients[int_adj, 'Estimate']
      
      # Calculate slope adjustment
      slope_derived <- slope + summary(mod)$coefficients[slope_adj, 'Estimate']
      
      # Calculate crossover
      co <- int_derived / slope_derived * -1
      
    }
    
    return(co)
    
  } else {
    
    stop("Error: this function requires a glm object\n", 
         "You have provided an object of class: ", class(mod)[1])
  }
  
}


# Analysis - I want the  L3 boundary /p/ or /u/ to be the dependent variable, 
# and to see whether this is predicted by the english boundary, spanish boundary, 
# L3 group, or order of acquisition. 

# I will calculate the boundaries for L1, L2 and L3. 
# The Model will be glm L3bound ~ order of acquisition, L3 group, eb, sb

#steps 
# get model to calculate boundaries for each participant, place this in a df and merge
# it to tidy df 

# run model and see results! 


ebv = all_vowels %>% 
  filter(., language == "english") %>% 
  group_by(participant) %>%
  summarise(ebv = mean(response))

sbv = all_vowels %>% 
  filter(., language == "spanish") %>% 
  group_by(participant) %>%
  summarise(sbv = mean(response))

fbv = all_vowels %>% 
  filter(., language == "french") %>% 
  group_by(participant) %>%
  summarise(l3bv = mean(response))

fbv = fbv %>%
  filter(!is.na(l3bv)) %>% 
  mutate(l3group = "f")

hbv = all_vowels %>% 
  filter(., language == "hungarian") %>% 
  group_by(participant) %>%
  summarise(l3bv = mean(response))

hbv = hbv %>%
  filter(!is.na(l3bv)) %>% 
  mutate(l3group = "h")


l3bv = rbind(fbv,hbv)

##  Merge LHQ data with 2afc data, filter out those who did not do all tasks. 

analyze_vowels = left_join(ebv, sbv, on = "participant") %>% 
  left_join(., l3bv, on = "participant") %>% 
  left_join(lhq, on = "participant") %>% 
  filter(!is.na(sbv)) %>% 
  filter(!is.na(l3bv)) %>% 
  mutate(group = if_else(l2 == "Spanish", "ES", "SE"))




## Descriptive stats of mean boundaries per group for vowels

analyze_vowels %>% 
  group_by(group) %>%
  summarise(mean_ebv = mean(ebv), sd_ebv = sd(ebv), mean_sbv = mean(sbv), sd(sbv), n = n())


### Filter for SE group and exclude participants who chose the same answer 90 percent of the time.

se_descreptive = analyze_vowels %>% 
  filter(group == "SE") %>% 
  mutate(es_effect = ebv - sbv) %>%
  filter(ebv < .9)

seh_descreptive = analyze_vowels %>% 
  filter(group == "SE") %>% 
  filter(l3group == "h") %>% 
  summarize(mean_ebv = mean(ebv), mean_sbv = mean(sbv), mean_l3bv = mean(l3bv), n = n())

sef_descreptive = analyze_vowels %>% 
  filter(group == "SE") %>% 
  filter(l3group == "f") %>% 
  summarize(mean_ebv = mean(ebv), mean_sbv = mean(sbv), mean_l3bv = mean(l3bv), n = n())

### Filter for ES group and exclude participants who chose the same answer 90 percent of the time. 

es_descreptive = analyze_vowels %>% 
  filter(group == "ES") %>% 
  mutate(es_effect = ebv - sbv) %>%
  filter(ebv < .9)

esh_descreptive = analyze_vowels %>% 
  filter(group == "ES") %>% 
  filter(l3group == "h") %>% 
  summarize(mean_ebv = mean(ebv), mean_sbv = mean(sbv), mean_l3bv = mean(l3bv), n = n())

esf_descreptive = analyze_vowels %>% 
  filter(group == "ES") %>% 
  filter(l3group == "f") %>% 
  summarize(mean_ebv = mean(ebv), mean_sbv = mean(sbv), mean_l3bv = mean(l3bv), n = n())


## paired T-test to see whether English and Spanish boundaries are significantly different. 

## In the SE group 
t.test(se_descreptive$ebv, se_descreptive$sbv, paired = TRUE)

## In the ES group
t.test(es_descreptive$ebv, es_descreptive$sbv, paired = TRUE)


## Fitting a model for vowel boundaries

analyze_vowels$l3group <- factor(analyze_vowels$l3group)

is.factor(analyze_vowels$l3group)


analyze_vowels$group <- factor(analyze_vowels$group)

is.factor(analyze_vowels$group)

glm_vowels = glm(l3bv ~ ebv, sbv, l3group, data = analyze_vowels, family = binomial(link = "logit"))


summary(glm_vowels)

# Plot L3 boundaries by order of acquisition 
ggplot(data = analyze_vowels, aes(x = group, y = l3bv, color = l3group)) + 
  geom_boxplot()

# Plot boundary per language per group 
analyze_vowels %>% 
  pivot_longer(c(`ebv`, `sbv`, `l3bv`), names_to = "language", values_to = "step") %>% 
  ggplot(., aes(x = group, y = step, color = language)) + geom_boxplot()

# Plot S-shaped curves per group 

# SEH vowels
all_vowels %>%
  filter(group == "SE") %>% 
  filter(l3group == "h") %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English Hungarian Vowels")


# SEF vowels
all_vowels %>%
  filter(group == "SE") %>% 
  filter(l3group == "f") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English French Vowels")

ttest_seh = analyze_vowels %>% 
  filter(l3group == "f") %>% 
  filter(group == "SE") 
  
t.test(ttest_seh$l3bv, ttest_seh$ebv, paired = TRUE)

# Facet SE group by l3 group

all_vowels %>%
  filter(group == "SE") %>% 
  filter(!is.na(l3group)) %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ l3group) + geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 Spanish L2 English Vowels")


# ESH vowels 

all_vowels %>%
  filter(group == "ES") %>% 
  filter(l3group == "h") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish Hungarian Vowels")

# ESF vowels 

all_vowels %>%
  filter(group == "ES") %>% 
  filter(l3group == "f") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish French Vowels")


# Facet ES group by l3 group

all_vowels %>%
  filter(group == "ES") %>% 
  filter(!is.na(l3group)) %>%
  ggplot(., aes(x = step_cont, y = response, color = language)) + 
  facet_grid(. ~ l3group) + geom_smooth(method = "glm", method.args = list(family = "binomial")) + 
  labs(title = "L1 English L2 Spanish Vowels")



