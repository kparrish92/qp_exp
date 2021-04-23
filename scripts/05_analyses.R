# Analyses --------------------------------------------------------------------
#
# Last update: 2021-03-27
# Describe what this script does here.
#
# -----------------------------------------------------------------------------



# Source libs, data, and models -----------------------------------------------

source(here::here("scripts", "00_libs.R"))
source(here("scripts", "01_tidy2afc.R"))
source(here("scripts", "02_load_data.R"))
source(here("scripts", "03_crossover.R"))
source(here("scripts", "04_tidy_lextale.R"))


# -----------------------------------------------------------------------------

#vCheck crossover and do pairwise comparisons

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
  "5fa0bf0afbd42f13cf56e987")

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
  "5f641323fc170219bf367bb9",
  "5fa379c756d0fe67b022823b"
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
  "5f174566f589920a8ba7e2df",
  "5e9546ebbc08e21354f19f4d",
  "5d3df88c6a5b1e0001a91d8d",
  "5f3344917a7a0b159bd0c375",
  "5fad49057daf5f0162284e86"
)

all_data %>% 
  filter(exp == "stops") %>%
  filter(participant == "5f3344917a7a0b159bd0c375") %>% 
  ggplot(., aes(x = step_cont, y = response, color = language)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"))




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

# Subset English and Spanish CO for both L1 groups & do paired t.tests - 
# looks to be all null before removal of participants from stops_remove and 
# vowels_remove - spanish/english vowels t.test p = .007

# stops english L1

q0_stops_e <- co_df %>% 
  filter(language == "spanish"| language == "english") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "English") %>% 
  select(participant, exp, language, co) %>% 
  pivot_wider(names_from = language, values_from = co)

t.test(q0_stops_e$english, x = q0_stops_e$spanish, paired = TRUE) # p = .33


# vowels english L1

q0_vowels_e <- co_df %>% 
  filter(language == "spanish"| language == "english") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>% 
  filter(l1 == "English") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co)

t.test(q0_vowels_e$english, x = q0_vowels_e$spanish, paired = TRUE) # p = .47


# stops spanish L1

q0_stops_s <- co_df %>% 
  filter(language == "spanish"| language == "english") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co)

t.test(q0_stops_s$english, x = q0_stops_s$spanish, paired = TRUE) # p = .28


# vowels spanish L1

q0_vowels_s <- co_df %>% 
  filter(language == "spanish"| language == "english") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co)

t.test(q0_vowels_s$english, x = q0_vowels_s$spanish, paired = TRUE) # p = .007*


# Subset English L1 group 

el1 = en_sp_2afc %>% 
  filter(l1 == "English") 
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

# S L1 group with hungarian paired t.test
q0_vowels_sh <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "hungarian") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(hungarian)) %>% 
  rename(l3 = hungarian) %>% 
  mutate(l3_group = "hungarian")




# spanish L1 

q0_vowels_sf <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "french") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(french)) %>% 
  rename(l3 = french) %>%
  mutate(l3_group = "french")

# combine both groups into 1 

spanl1_vowels = rbind(q0_vowels_sf, q0_vowels_sh) %>% 
  rename(l2 = english) %>% 
  rename(group = l1) %>% 
  rename(l1 = spanish)

# English l1 groups

# English hungarian group 

q0_vowels_eh <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "hungarian") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  filter(l1 == "English") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(hungarian)) %>% 
  rename(l3 = hungarian) %>% 
  mutate(l3_group = "hungarian")



# English french group 

q0_vowels_ef <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "french") %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  filter(l1 == "English") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(french)) %>% 
  rename(l3 = french) %>% 
  mutate(l3_group = "french")

# bind dfs together after tidying
engl1vowels = rbind(q0_vowels_ef, q0_vowels_eh) %>% 
  rename(l2 = spanish) %>% 
  rename(group = l1) %>% 
  rename(l1 = english)


all_vowels = rbind(engl1vowels, spanl1_vowels)


# Stops 

# English L1 

q0_stops_eh <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "hungarian") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "English") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(hungarian)) %>% 
  rename(l3 = hungarian) %>% 
  mutate(l3_group = "hungarian")

q0_stops_ef <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "french") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "English") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(french)) %>% 
  rename(l3 = french) %>% 
  mutate(l3_group = "french")

# Spanish L1 

q0_stops_sh <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "hungarian") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(hungarian)) %>% 
  rename(l3 = hungarian) %>% 
  mutate(l3_group = "hungarian")

q0_stops_sf <- co_df %>% 
  filter(language == "spanish"| language == "english" | language == "french") %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  filter(l1 == "Spanish") %>% 
  select(participant, exp, language, co, l1) %>% 
  pivot_wider(names_from = language, values_from = co) %>% 
  filter(!is.na(french)) %>% 
  rename(l3 = french) %>% 
  mutate(l3_group = "french")


all_stops = rbind(q0_stops_ef, q0_stops_eh, q0_stops_sh, q0_stops_sf)

# Spanish L1 group stops t.tests 

all_spanish_stops = rbind(q0_stops_sf, q0_stops_sh)

t.test(all_spanish_stops$english, all_spanish_stops$spanish, paired = TRUE)
t.test(q0_stops_sf$english, q0_stops_sf$l3, paired = TRUE)
t.test(q0_stops_sf$spanish, q0_stops_sf$l3, paired = TRUE)


t.test(q0_stops_sh$english, q0_stops_sh$l3, paired = TRUE)
t.test(q0_stops_sh$spanish, q0_stops_sh$l3, paired = TRUE)



t.test(q0_stops_sf$l3, q0_stops_sh$l3)

# English L1 group stops t.tests


all_english_stops = rbind(q0_stops_ef, q0_stops_eh)

t.test(all_english_stops$english, all_english_stops$spanish, paired = TRUE)

t.test(q0_stops_ef$english, q0_stops_ef$l3, paired = TRUE)
t.test(q0_stops_ef$spanish, q0_stops_ef$l3, paired = TRUE)

t.test(q0_stops_eh$english, q0_stops_eh$l3, paired = TRUE) #*
t.test(q0_stops_eh$spanish, q0_stops_eh$l3, paired = TRUE)

t.test(q0_stops_eh$spanish, q0_stops_eh$english, paired = TRUE)
t.test(q0_stops_ef$spanish, q0_stops_ef$english, paired = TRUE)

t.test(q0_stops_ef$l3, q0_stops_eh$l3)


# -----------------------------------------------------------------------------



# T.tests


# S L1 group with french paired t.test

# English/Spanish boundary effect is present 
t.test(q0_vowels_sf$english, q0_vowels_sf$spanish, paired = TRUE) # p = .000000009*

#  French and English are different in SEF group 
t.test(q0_vowels_sf$english, q0_vowels_sf$l3, paired = TRUE) # p = .00005*

# Spanish and French are not different in SEF group 
t.test(q0_vowels_sf$spanish, q0_vowels_sf$l3, paired = TRUE) # p = .37





# RQ2 -------------------------------------------------------------------------
#
# Will perceptual categorization of "Hungarian" and "French" result in 
# different "language specific" categorization?
#
# Spanish-English bilinguals who believe that they are hearing a romance L3 
# should have more Spanish-like boundaries


# Did the two se groups categorize eng and span the same? 

# eng
t.test(q0_vowels_sf$english, q0_vowels_sh$english) # yes - p = .79 

# span 
t.test(q0_vowels_sf$spanish, q0_vowels_sh$spanish) # yes - p = .658


# Fren and hung comp: the same?

t.test(q0_vowels_sf$l3, q0_vowels_sh$l3) # yes - p = .77



# -----------------------------------------------------------------------------

# Bonus RQ - post hoc. 
# Does proficiency predict the boundary effect? 

# vowels 

# Plot to eye-ball it - looks relatively flat 

co_df_vowels = co_df_prof %>% 
  filter(exp == "vowels", !(participant %in% vowels_remove)) %>%
  select(participant, exp, language, co, l1, score) %>%
  pivot_wider(names_from = language, values_from = co) %>%
  mutate(co_diff = english - spanish) %>%
  mutate(zscore = (co_diff - mean(co_diff))/sd(co_diff))


co_df_vowels %>% 
  ggplot(., aes(x = score, y = co_diff)) + geom_point() +
  geom_smooth(method = lm, method.args = list(family = "binomial")) + ggtitle("vowels")

# stops 

# subset stops and add co_diff column 
co_df_stops = co_df_prof %>% 
  filter(exp == "stops", !(participant %in% stops_remove)) %>%
  select(participant, exp, language, co, l1, score) %>%
  pivot_wider(names_from = language, values_from = co) %>%
  mutate(co_diff = english - spanish) %>%
  mutate(zscore = (co_diff - mean(co_diff))/sd(co_diff))

# Plot to eye-ball it 

co_df_stops %>% 
  ggplot(., aes(x = score, y = co_diff)) + geom_point() +
  geom_smooth(method = lm, method.args = list(family = "binomial")) + ggtitle("stops")


# model for stops - proficiency does not explain the variation in boundary size

stops_model_null = lm(co_diff ~ 1, data = co_df_stops)
stops_model_1 = lm(co_diff ~ score, data = co_df_stops)
stops_model_2 = lm(co_diff ~ score*l1, data = co_df_stops)




# Models 

# expect:
# main effect for l1 co
# main effect for l1 
# l1 co * l1 interaction

glimpse(all_vowels)

model_vowels = lm(l3 ~ 1, data = all_vowels)
model_vowels2 = lm(l3 ~ l1, data = all_vowels) #
model_vowels3 = lm(l3 ~ l1 + l2, data = all_vowels) #
model_vowels4 = lm(l3 ~ l3_group, data = all_vowels) # 


anova(model_vowels, model_vowels2, model_vowels3, model_vowels4)


summary(model_vowels4)


# span l1 vowels model 

spanl1_vowels = spanl1_vowels %>% 
  filter(!(participant %in% vowels_remove))


model_svowels = lm(l3 ~ 1, data = spanl1_vowels)
model_svowels2 = lm(l3 ~ l1, data = spanl1_vowels) # main effect for l1
model_svowels3 = lm(l3 ~ l1 + l2, data = spanl1_vowels) # main effect for l2 
model_svowels4 = lm(l3 ~ l1*l2, data = spanl1_vowels) # l1 * l2 interaction, no main effect for L2 
model_svowels5 = lm(l3 ~ l1*l2 + l3_group, data = spanl1_vowels) # no effect for l3 group 

summary(model_svowels4)

anova(model_svowels, model_svowels2, model_svowels3, model_svowels4, model_svowels5)

# Span l1 stops model w trimmed data 

spanl1_stops = all_stops %>% 
  filter(l1 == "Spanish") %>% 
  filter(!(participant %in% stops_remove))

# fit models for stops - mean effect for Spanish, and significant in model, but not in t-test...
model_sstops = lm(l3 ~ 1, data = spanl1_stops)
model_sstops2 = lm(l3 ~ spanish, data = spanl1_stops) # main effect for l1
model_sstops3 = lm(l3 ~ spanish + english, data = spanl1_stops) # main effect for l2 
model_sstops4 = lm(l3 ~ spanish*english, data = spanl1_stops) # l1 * l2 interaction, no main effect for L2 


anova(model_sstops, model_sstops2,model_sstops3,model_sstops4)

summary(model_sstops2)

t.test(spanl1_stops$english, spanl1_stops$spanish, paired = TRUE)


# -------------------------------------------------------------------------------
  
# english l1 stops model w trimmed data 

engl1_stops = all_stops %>% 
  filter(l1 == "English") %>% 
  filter(!(participant %in% stops_remove))

# fit models for stops - mean effect for Spanish, and significant in model, but not in t-test...
model_estops = lm(l3 ~ 1, data = engl1_stops)
model_estops2 = lm(l3 ~ spanish, data = engl1_stops) 
model_estops3 = lm(l3 ~ spanish + english, data = engl1_stops) 
model_estops4 = lm(l3 ~ spanish*english, data = engl1_stops) 


anova(model_estops, model_estops2,model_estops3,model_estops4)

summary(model_estops2)

t.test(engl1_stops$english, engl1_stops$spanish, paired = TRUE)


### english l1 vowel model w trimmed data

engl1_vowels = all_stops %>% 
  filter(l1 == "English") %>% 
  filter(!(participant %in% stops_remove))


model_evowels = lm(l3 ~ 1, data = engl1_vowels)
model_evowels2 = lm(l3 ~ english, data = engl1_vowels) # main effect for l1
model_evowels3 = lm(l3 ~ english + spanish, data = engl1_vowels) # main effect for l2 
model_evowels4 = lm(l3 ~ english*spanish, data = engl1_vowels) # l1 * l2 interaction, no main effect for L2 
model_evowels5 = lm(l3 ~ english*spanish + l3_group, data = engl1_vowels) # no effect for l3 group 

summary(model_evowels2)

anova(model_evowels, model_evowels2, model_evowels3, model_evowels4, model_evowels5)





# vowels 

ef_list_vowels = q0_vowels_ef %>% 
  select(participant, l3_group)

eh_list_vowels = q0_vowels_eh %>% 
  select(participant, l3_group)

sf_list_vowels = q0_vowels_sf %>% 
  select(participant, l3_group)

sh_list_vowels = q0_vowels_sh %>% 
  select(participant, l3_group)

l3_vowel_groups = rbind(ef_list_vowels, eh_list_vowels, sf_list_vowels, sh_list_vowels)

# stops 

ef_list_stops = q0_stops_ef %>% 
  select(participant, l3_group)

eh_list_stops = q0_stops_eh %>% 
  select(participant, l3_group)

sf_list_stops = q0_stops_sf %>% 
  select(participant, l3_group)

sh_list_stops = q0_stops_sh %>% 
  select(participant, l3_group)

l3_stops_groups = rbind(ef_list_stops, eh_list_stops, sf_list_stops, sh_list_stops)



# prof per group 

# average lextale per l1 
co_df_prof %>% 
  group_by(l1) %>% 
  summarise(mean_lextale = mean(score))

# was this difference in group means significant? 
# yep. the spanish speakers difference in proficient scores is not due to variance. 
t.test(english_lextale$score, spanish_lextale$lextale_avg)


  
  

# 

hung = all_data %>%
  filter(!(participant %in% vowels_remove)) %>%
  filter(exp == "vowels") %>% 
  filter(l1 == "Spanish") %>% 
  filter((participant %in% all_3_hu |participant %in% all_3_fr)) 

model_hung = glmer(response ~ language + (language | participant), family = binomial(link = "logit"), data = hung)

summary(model_hung)
  
fren = all_data %>%
  filter(!(participant %in% vowels_remove)) %>%
  filter(exp == "vowels") %>% 
  filter((participant %in% all_3_fr)) 

model_hung = glmer(response ~ language + (language | participant), family = binomial(link = "logit"), data = fren)
