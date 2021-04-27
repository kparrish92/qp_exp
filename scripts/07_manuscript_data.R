# Small data ------------------------------------------------------------------

# This script loads all data and models and extracts descriptive info
# reporting in papaja manuscript

# Adapted from Lozano Argüelles et al. (2020) https://osf.io/m4u2y/

#------------------------------------------------------------------------------

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

#

vowels_remove <- c(
  "5ec5a561c1172f5f55cfb425", 
  "5ee579ecd4169f2bee94041e", 
  "5f3020ed291f7344af6d82e1", 
  "5f641323fc170219bf367bb9",
  "5fa379c756d0fe67b022823b"
)





# Source libs, helpers, and load data -----------------------------------------

source(here::here("scripts", "00_libs.R"))


#------------------------------------------------------------------------------

# desc info with co 

desc_vowels = read.csv(here("data", "tidy", "desc_vowels.csv")) %>%
  unite("group", l1, l3_group, sep="_") %>% 
  group_by(group) %>% 
  summarise(`Mean English Crossover` = mean(english), 
            `SD English` = sd(english),
            `Mean Spanish Crossover` = mean(spanish), 
            `SD Spanish` = sd(spanish),
            `Mean L3 Crossover` = mean(l3),
            `SD L3` = sd(l3), n = n())

desc_stops = read.csv(here("data", "tidy", "desc_stops.csv")) %>%
  unite("group", l1, l3_group, sep="_") %>% 
  group_by(group) %>% 
  summarise(`Mean English Crossover` = mean(english), 
            `SD English` = sd(english),
            `Mean Spanish Crossover` = mean(spanish), 
            `SD Spanish` = sd(spanish),
            `Mean L3 Crossover` = mean(l3),
            `SD L3` = sd(l3), n = n())


# Get small data --------------------------------------------------------------


language_n = read.csv(here("data", "tidy", "language_n.csv"))

n = sum(language_n$n)

language_n_man = language_n %>% 
  pivot_wider(values_from = n, names_from = language)


all_data = read.csv(here("data", "tidy", "all_2afc.csv"))

per_group = all_data %>% 
  .[!duplicated(all_data$participant), ] %>% 
  group_by(l1) %>%
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

# load data 
m_english_removed_stops = read.csv(here("data", "tidy", "m_english_removed_stops.csv"))
m_spanish_removed_stops = read.csv(here("data", "tidy", "m_spanish_removed_stops.csv"))
m_french_removed_stops = read.csv(here("data", "tidy", "m_french_removed_stops.csv"))
m_hungarian_removed_stops = read.csv(here("data", "tidy", "m_hungarian_removed_stops.csv"))


# ------------------------------------------------------------------------------


# Find number of participants per group 

# Get a list of IDS with L1 infor for grouping 
id_list = all_data %>% 
  .[!duplicated(all_data$participant), ]

# make list of ids who did all 3 in FR group and join with id_list to create l1 
# groups for manuscript 

# French for both Eng and Span L1
m_all_3_fr = 
  read.csv(here("data", "tidy", "all_3_fr.csv")) %>%
  rename(., participant = .) %>% 
  left_join(id_list, by = "participant") %>% 
  group_by(l1) %>% 
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

# Hungarian for both Eng and Span L1 

m_all_3_hu = 
  read.csv(here("data", "tidy", "all_3_hu.csv")) %>%
  rename(., participant = .) %>% 
  left_join(id_list, by = "participant") %>% 
  group_by(l1) %>% 
  summarise(n = n()) %>% 
  pivot_wider(values_from = n, names_from = l1) 

#-------------------------------------------------------------------------------

# Load t-test data 

q0_vowels_s = read.csv(here("data", "tidy", "subsets", "q0_vowels_s.csv"))
q0_vowels_e = read.csv(here("data", "tidy", "subsets", "q0_vowels_e.csv"))
q0_stops_s = read.csv(here("data", "tidy", "subsets", "q0_stops_s.csv"))
q0_stops_e = read.csv(here("data", "tidy", "subsets", "q0_stops_e.csv"))
q0_vowels_sh = read.csv(here("data", "tidy", "subsets", "q0_vowels_sh.csv"))
q0_vowels_eh = read.csv(here("data", "tidy", "subsets", "q0_vowels_eh.csv"))
q0_vowels_ef = read.csv(here("data", "tidy", "subsets", "q0_vowels_ef.csv"))
q0_vowels_sf = read.csv(here("data", "tidy", "subsets", "q0_vowels_sf.csv"))
q0_stops_sh = read.csv(here("data", "tidy", "subsets", "q0_stops_sh.csv"))
q0_stops_eh = read.csv(here("data", "tidy", "subsets", "q0_stops_eh.csv"))
q0_stops_sf = read.csv(here("data", "tidy", "subsets", "q0_stops_sf.csv"))
q0_stops_ef = read.csv(here("data", "tidy", "subsets", "q0_stops_ef.csv"))

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



