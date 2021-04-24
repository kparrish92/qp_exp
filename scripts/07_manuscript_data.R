# Small data ------------------------------------------------------------------

# This script loads all data and models and extracts descriptive info
# reporting in papaja manuscript

# Adapted from Lozano Argüelles et al. (2020) https://osf.io/m4u2y/

#------------------------------------------------------------------------------





# Source libs, helpers, and load data -----------------------------------------

source(here::here("scripts", "00_libs.R"))
source(here("scripts", "01_tidy2afc.R"))
source(here("scripts", "02_load_data.R"))
source(here("scripts", "03_crossover.R"))
source(here("scripts", "04_tidy_lextale.R"))
source(here("scripts", "05_analyses.R"))

#------------------------------------------------------------------------------

# desc info with co 

desc_vowels = rbind(q0_vowels_ef, q0_vowels_eh, q0_vowels_sh, q0_vowels_sf) %>%
  unite("group", l1, l3_group, sep="_") %>% 
  group_by(group) %>% 
  summarise(`Mean English Crossover` = mean(english), 
            `SD English` = sd(english),
            `Mean Spanish Crossover` = mean(spanish), 
            `SD Spanish` = sd(spanish),
            `Mean L3 Crossover` = mean(l3),
            `SD L3` = sd(l3), n = n())

desc_stops = rbind(q0_stops_ef, q0_stops_eh, q0_stops_sh, q0_stops_sf) %>%
  unite("group", l1, l3_group, sep="_") %>% 
  group_by(group) %>% 
  summarise(`Mean English Crossover` = mean(english), 
            `SD English` = sd(english),
            `Mean Spanish Crossover` = mean(spanish), 
            `SD Spanish` = sd(spanish),
            `Mean L3 Crossover` = mean(l3),
            `SD L3` = sd(l3), n = n())




# 

# model_svowels

apa_svowels <- apa_print(model_svowels5)


# Get small data --------------------------------------------------------------


n = sum(language_n$n)

language_n_man = language_n %>% 
  pivot_wider(values_from = n, names_from = language)


per_group = all_data %>% 
  .[!duplicated(all_data$participant), ] %>% 
  group_by(l1) %>%
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

# removed participants for low-effort submission - reformatting for manuscript

# English - 
en_removed_stops = tibble(en_stops_remove) %>% 
  mutate(n = 1)

m_english_removed_stops = sum(en_removed_stops$n) %>% 
  tibble() %>% 
  rename(., n = .)

# Spanish

sp_removed_stops = tibble(sp_stops_remove) %>% 
  mutate(n = 1)

m_spanish_removed_stops = sum(sp_removed_stops$n) %>% 
  tibble() %>% 
  rename(., n = .)

# french


fr_removed_stops = tibble(fr_stops_remove) %>% 
  mutate(n = 1)

m_french_removed_stops = sum(fr_removed_stops$n) %>% 
  tibble() %>% 
  rename(., n = .)


# hungarian 


hu_removed_stops = tibble(hu_stops_remove) %>% 
  mutate(n = 1)

m_hungarian_removed_stops = sum(hu_removed_stops$n) %>% 
  tibble() %>% 
  rename(., n = .)

# ------------------------------------------------------------------------------


# Find number of participants per group 

# Get a list of IDS with L1 infor for grouping 
id_list = all_data %>% 
  .[!duplicated(all_data$participant), ]

# make list of ids who did all 3 in FR group and join with id_list to create l1 
# groups for manuscript 

# French for both Eng and Span L1
m_all_3_fr = tibble(all_3_fr) %>%
  rename(., participant = all_3_fr) %>% 
  left_join(id_list, by = "participant") %>% 
  group_by(l1) %>% 
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

# Hungarian for both Eng and Span L1 

m_all_3_hu = tibble(all_3_hu) %>%
  rename(., participant = all_3_hu) %>% 
  left_join(id_list, by = "participant") %>% 
  group_by(l1) %>% 
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

#-------------------------------------------------------------------------------

# T.tests for results section 

# Span Eng per boundary 

sl1ves = apa_print(t.test(q0_vowels_s$english, q0_vowels_s$spanish, paired = TRUE))
el1ves = apa_print(t.test(q0_vowels_e$english, q0_vowels_e$spanish, paired = TRUE))

sl1ses = apa_print(t.test(q0_stops_s$english, q0_stops_s$spanish, paired = TRUE))
el1ses = apa_print(t.test(q0_stops_e$english, q0_stops_e$spanish, paired = TRUE))

# per subgroup 

sl1hes = apa_print(t.test(q0_vowels_sh$english, q0_vowels_sh$spanish, paired = TRUE))
el1hes = apa_print(t.test(q0_vowels_eh$english, q0_vowels_eh$spanish, paired = TRUE))
sl1fes = apa_print(t.test(q0_vowels_ef$english, q0_vowels_ef$spanish, paired = TRUE))
el1fes = apa_print(t.test(q0_vowels_sf$english, q0_vowels_sf$spanish, paired = TRUE))

sl1hess = apa_print(t.test(q0_stops_sh$english, q0_stops_sh$spanish, paired = TRUE))
el1hess = apa_print(t.test(q0_stops_eh$english, q0_stops_eh$spanish, paired = TRUE))
sl1fess = apa_print(t.test(q0_stops_sf$english, q0_stops_sf$spanish, paired = TRUE))
el1fess = apa_print(t.test(q0_stops_ef$english, q0_stops_ef$spanish, paired = TRUE))

# L2 to L3 tests 
# ------------------------------------------------------------------------------
sl1veh = apa_print(t.test(q0_vowels_sh$english, q0_vowels_sh$l3, paired = TRUE)) # p = .017*
sl1vef = apa_print(t.test(q0_vowels_sf$english, q0_vowels_sf$l3, paired = TRUE))
sl1seh = apa_print(t.test(q0_stops_sh$english, q0_stops_sh$l3, paired = TRUE)) # p = .017*
sl1sef = apa_print(t.test(q0_stops_sf$english, q0_stops_sf$l3, paired = TRUE))

el1ssf = apa_print(t.test(q0_stops_ef$spanish, q0_stops_ef$l3, paired = TRUE))
el1ssh = apa_print(t.test(q0_stops_eh$spanish, q0_stops_eh$l3, paired = TRUE))
el1vsf = apa_print(t.test(q0_vowels_ef$spanish, q0_vowels_ef$l3, paired = TRUE))
el1vsh = apa_print(t.test(q0_vowels_eh$spanish, q0_vowels_eh$l3, paired = TRUE))

# L1 to L3 tests 
# ------------------------------------------------------------------------------
sl1vsh = apa_print(t.test(q0_vowels_sh$spanish, q0_vowels_sh$l3, paired = TRUE)) # p = .017*
sl1vsf = apa_print(t.test(q0_vowels_sf$spanish, q0_vowels_sf$l3, paired = TRUE))
sl1ssh = apa_print(t.test(q0_stops_sh$spanish, q0_stops_sh$l3, paired = TRUE)) 
sl1ssf = apa_print(t.test(q0_stops_sf$spanish, q0_stops_sf$l3, paired = TRUE))


el1vef = apa_print(t.test(q0_vowels_ef$english, q0_vowels_ef$l3, paired = TRUE))
el1veh = apa_print(t.test(q0_vowels_eh$english, q0_vowels_eh$l3, paired = TRUE))
el1sef = apa_print(t.test(q0_stops_ef$english, q0_stops_ef$l3, paired = TRUE))
el1seh = apa_print(t.test(q0_stops_eh$english, q0_stops_eh$l3, paired = TRUE))


# non-paired t-test between l3 groups 
# ------------------------------------------------------------------------------
sl1vfh = apa_print(t.test(q0_vowels_sh$l3, q0_vowels_sf$l3))
sl1sfh = apa_print(t.test(q0_stops_sh$l3, q0_stops_sf$l3))
el1vfh = apa_print(t.test(q0_vowels_eh$l3, q0_vowels_ef$l3))
el1sfh = apa_print(t.test(q0_stops_eh$l3, q0_stops_ef$l3))

# Post hoc t.tests
# --------------------------------------

# Tidy for t.test 

spanish_pooled_stops = rbind(q0_stops_sf, q0_stops_sh)
spanish_pooled_vowels = rbind(q0_vowels_sf, q0_vowels_sh) 
english_pooled_stops = rbind(q0_stops_ef, q0_stops_eh)

pooled_stops_sl1_se = apa_print(t.test(spanish_pooled_stops$english, spanish_pooled_stops$spanish, paired = TRUE))
pooled_stops_sl1_sl3 = apa_print(t.test(spanish_pooled_stops$spanish, spanish_pooled_stops$l3, paired = TRUE))
pooled_stops_sl1_el3 = apa_print(t.test(spanish_pooled_stops$english, spanish_pooled_stops$l3, paired = TRUE))

pooled__vowel_sl1_se = apa_print(t.test(spanish_pooled_vowels$english, spanish_pooled_vowels$spanish, paired = TRUE))
pooled__vowel_sl1_sl3 = apa_print(t.test(spanish_pooled_vowels$l3, spanish_pooled_vowels$spanish, paired = TRUE))
pooled__vowel_sl1_el3 = apa_print(t.test(spanish_pooled_vowels$english, spanish_pooled_vowels$l3, paired = TRUE))

pooled_stops_el1_se = apa_print(t.test(english_pooled_stops$english, english_pooled_stops$spanish, paired = TRUE))
pooled_stops_el1_sl3 = apa_print(t.test(english_pooled_stops$l3, english_pooled_stops$spanish, paired = TRUE))
pooled_stops_el1_el3 = apa_print(t.test(english_pooled_stops$english, english_pooled_stops$l3, paired = TRUE))



# put results of t.tests in df 

spanish_english_ttests = 
  tibble(sl1ves$statistic,el1ves$statistic,sl1ses$statistic,el1ses$statistic) %>% 
  pivot_longer(c(`sl1ves$statistic`, `el1ves$statistic`, `el1ses$statistic`, `sl1ses$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("Spanish L1", "English L1", "Spanish L1", "English L1")) %>% 
  mutate(Feature = c("Vowels", "Vowels", "Stops", "Stops")) %>% 
  mutate(Pairing = c("English-Spanish", "English-Spanish", "English-Spanish", "English-Spanish"))



es_pergroup_vowels = tibble(sl1hes$statistic, sl1fes$statistic, el1fes$statistic, el1hes$statistic) %>%
  pivot_longer(c(`sl1hes$statistic`, `sl1fes$statistic`, `el1fes$statistic`, `el1hes$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("Spanish L1", "Spanish L1", "English L1", "English L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Spanish", "English-Spanish", "English-Spanish", "English-Spanish"))


es_pergroup_stops = tibble(sl1hess$statistic,sl1fess$statistic,el1fess$statistic,
                           el1hess$statistic) %>%
  pivot_longer(c(`sl1hess$statistic`, `sl1fess$statistic`, `el1fess$statistic`, `el1hess$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("Spanish L1", "Spanish L1", "English L1", "English L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Spanish", "English-Spanish", "English-Spanish", "English-Spanish"))

# -------------------------------------------------------------------------------

span_ttests_v = tibble(sl1veh$statistic,sl1vef$statistic,sl1vsf$statistic,
                         sl1vsh$statistic) %>%
  pivot_longer(c(`sl1veh$statistic`, `sl1vef$statistic`, `sl1vsf$statistic`, `sl1vsh$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("Spanish L1", "Spanish L1", "Spanish L1", "Spanish L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Hungarian", "English-French", "Spanish-French", "Spanish-Hungarian"))



span_ttests_s = tibble(sl1seh$statistic,sl1sef$statistic,sl1ssf$statistic,
                       sl1ssh$statistic) %>%
  pivot_longer(c(`sl1seh$statistic`, `sl1sef$statistic`, `sl1ssf$statistic`, `sl1ssh$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("Spanish L1", "Spanish L1", "Spanish L1", "Spanish L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Hungarian", "English-French", "Spanish-French", "Spanish-Hungarian"))


# -------------------------------------------------------------------------------------------

eng_ttests_v = tibble(el1veh$statistic,el1vef$statistic,el1vsf$statistic,
                       el1vsh$statistic) %>%
  pivot_longer(c(`el1veh$statistic`, `el1vef$statistic`, `el1vsf$statistic`, `el1vsh$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("English L1", "English L1", "English L1", "English L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Hungarian", "English-French", "Spanish-French", "Spanish-Hungarian"))



eng_ttests_s = tibble(el1seh$statistic,el1sef$statistic,el1ssf$statistic,
                      el1ssh$statistic) %>%
  pivot_longer(c(`el1seh$statistic`, `el1sef$statistic`, `el1ssf$statistic`, `el1ssh$statistic`), 
               names_to = "test", values_to = "statistic") %>% 
  separate(statistic, into = c("t", "p-value"), sep = ",") %>% 
  separate(t , into = c("df", "t"), sep = "=") %>% 
  mutate(Groups = c("English L1", "English L1", "English L1", "English L1")) %>% 
  mutate(L3_group = c("Hungarian", "French", "French", "Hungarian")) %>% 
  mutate(Pairing = c("English-Hungarian", "English-French", "Spanish-French", "Spanish-Hungarian"))



# --------------------------------------------------------------------------------------------



