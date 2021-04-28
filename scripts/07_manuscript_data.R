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


# Proficiency TOST 


all_lextale_tidy = read.csv(here("data", "tidy", "co_df_prof.csv")) %>% 
  filter(!(participant %in% vowels_remove)) %>%
  filter(!(participant %in% stops_remove)) %>%
  dplyr::select(l1, score, participant)

all_lextale_tidy = all_lextale_tidy %>% 
  .[!duplicated(all_lextale_tidy$participant), ] %>% 
  pivot_wider(names_from = l1, values_from = score)

eng_lextale = all_lextale_tidy %>% 
  filter(!is.na(English))

span_lextale = all_lextale_tidy %>% 
  filter(!is.na(Spanish))

# objects for proficiency tost 

englexmean = mean(eng_lextale$English)
englexsd = sd(eng_lextale$English)
spanlexmean = mean(span_lextale$Spanish)
spanlexsd = sd(span_lextale$Spanish)

## Proficiency tost 
tost_prof = TOSTtwo(m1 = spanlexmean, m2 = englexmean, sd1 = spanlexsd, sd2 = englexsd, n1 = 25, n2 = 47, 
        low_eqbound_d = -.1, high_eqbound_d = .1, alpha = 0.05, 
        var.equal = FALSE)

# ----------------------------------------------------------------------------------------
# SE stops 

boundary_diff_sl1s = mean(q0_stops_s$english) - mean(q0_stops_s$spanish)

tost_l3_spanl1_stops_se = TOSTpaired(n = 46, m1 = mean(spanish_pooled_stops$english), 
                                  m2 = mean(spanish_pooled_stops$spanish),
                                  sd1 = sd(spanish_pooled_stops$english),
                                  sd2 = sd(spanish_pooled_stops$spanish),
                                  r12 = cor(spanish_pooled_stops$english, spanish_pooled_stops$spanish), 
                                  low_eqbound_dz = -.5,
                                  high_eqbound_dz = .5,
                                  alpha = .05, plot = TRUE, verbose = TRUE)

tost_l3_spanl1_stops_el3 = TOSTpaired(n = 46, m1 = mean(spanish_pooled_stops$english), 
                                     m2 = mean(spanish_pooled_stops$l3),
                                     sd1 = sd(spanish_pooled_stops$english),
                                     sd2 = sd(spanish_pooled_stops$l3),
                                     r12 = cor(spanish_pooled_stops$english, spanish_pooled_stops$l3), 
                                     low_eqbound_dz = -.5,
                                     high_eqbound_dz = .5,
                                     alpha = .05, plot = TRUE, verbose = TRUE)


tost_l3_spanl1_stops_sl3 = TOSTpaired(n = 46, m1 = mean(spanish_pooled_stops$l3), 
                                     m2 = mean(spanish_pooled_stops$spanish),
                                     sd1 = sd(spanish_pooled_stops$l3),
                                     sd2 = sd(spanish_pooled_stops$spanish),
                                     r12 = cor(spanish_pooled_stops$spanish, spanish_pooled_stops$l3), 
                                     low_eqbound_dz = -.5,
                                     high_eqbound_dz = .5,
                                     alpha = .05, plot = TRUE, verbose = TRUE)

tost_l3_spanl1_stops_se = (as.data.frame(tost_l3_spanl1_stops_se)) %>% 
  mutate(combination = "Spanish English")

tost_l3_spanl1_stops_el3 = (as.data.frame(tost_l3_spanl1_stops_el3)) %>% 
  mutate(combination = "English L3")

tost_l3_spanl1_stops_sl3 = (as.data.frame(tost_l3_spanl1_stops_sl3)) %>% 
  mutate(combination = "Spanish L3")

all_tost_spanl1_stops = rbind(tost_l3_spanl1_stops_sl3,
                               tost_l3_spanl1_stops_el3,
                               tost_l3_spanl1_stops_se)                                   

all_tost_spanl1_stops %>% 
  ggplot(aes(x = diff, y = combination)) + geom_point() + 
  geom_linerange(aes(xmin = LL_CI_TOST, xmax = UL_CI_TOST)) +
  geom_vline(xintercept = all_tost_spanl1_stops$low_eqbound, linetype = "dashed") +
  geom_vline(xintercept = all_tost_spanl1_stops$high_eqbound, linetype = "dashed") +
  ggtitle("Spanish L1 stops")



# ----------------------------------------------------------------------------------------

# determine upper and lower bounds based on SE boundary of this group 


boundary_diff_sl1v = mean(q0_vowels_s$english) - mean(q0_vowels_s$spanish)


tost_l3_spanl1_vowels_se = TOSTpaired(n = 46, m1 = mean(spanish_pooled_vowels$english), 
                                     m2 = mean(spanish_pooled_vowels$spanish),
                                     sd1 = sd(spanish_pooled_vowels$english),
                                     sd2 = sd(spanish_pooled_vowels$spanish),
                                     r12 = cor(spanish_pooled_vowels$english, spanish_pooled_vowels$spanish), 
                                     low_eqbound_dz = -.5,
                                     high_eqbound_dz = .5,
                                     alpha = .05, plot = TRUE, verbose = TRUE)

tost_l3_spanl1_vowels_el3 = TOSTpaired(n = 46, m1 = mean(spanish_pooled_vowels$english), 
                                      m2 = mean(spanish_pooled_vowels$l3),
                                      sd1 = sd(spanish_pooled_vowels$english),
                                      sd2 = sd(spanish_pooled_vowels$l3),
                                      r12 = cor(spanish_pooled_vowels$english, spanish_pooled_vowels$l3), 
                                      low_eqbound_dz = -.5,
                                      high_eqbound_dz = .5,
                                      alpha = .05, plot = TRUE, verbose = TRUE)


tost_l3_spanl1_vowels_sl3 = TOSTpaired(n = 46, m1 = mean(spanish_pooled_vowels$l3), 
                                      m2 = mean(spanish_pooled_vowels$spanish),
                                      sd1 = sd(spanish_pooled_vowels$l3),
                                      sd2 = sd(spanish_pooled_vowels$spanish),
                                      r12 = cor(spanish_pooled_vowels$spanish, spanish_pooled_vowels$l3), 
                                      low_eqbound_dz = -.5,
                                      high_eqbound_dz = .5,
                                      alpha = .05, plot = TRUE, verbose = TRUE)


tost_l3_spanl1_vowels_sl3_df = (as.data.frame(tost_l3_spanl1_vowels_sl3)) %>% 
  mutate(combination = "Spanish L3")
                                   
tost_l3_spanl1_vowels_el3 = (as.data.frame(tost_l3_spanl1_vowels_el3)) %>% 
  mutate(combination = "English L3")

tost_l3_spanl1_vowels_se = (as.data.frame(tost_l3_spanl1_vowels_se)) %>% 
  mutate(combination = "Spanish English")

all_tost_spanl1_vowels = rbind(tost_l3_spanl1_vowels_sl3_df,
                               tost_l3_spanl1_vowels_el3,
                               tost_l3_spanl1_vowels_se)                                   

all_tost_spanl1_vowels %>% 
  ggplot(aes(x = diff, y = combination)) + geom_point() + 
  geom_linerange(aes(xmin = LL_CI_TOST, xmax = UL_CI_TOST)) +
  geom_vline(xintercept = all_tost_spanl1_vowels$low_eqbound, linetype = "dashed") +
  geom_vline(xintercept = all_tost_spanl1_vowels$high_eqbound, linetype = "dashed") + 
  ggtitle("Spanish L1 Vowels")
  



# ---------------------------------------------------------------------------------------
# ES stops 


boundary_diff_el1s = mean(q0_stops_e$english) - mean(q0_stops_e$spanish)


tost_l3_engl1_stops_se = TOSTpaired(n = 23, m1 = mean(english_pooled_stops$english), 
                                     m2 = mean(english_pooled_stops$spanish),
                                     sd1 = sd(english_pooled_stops$english),
                                     sd2 = sd(english_pooled_stops$spanish),
                                     r12 = cor(english_pooled_stops$english, english_pooled_stops$spanish), 
                                     low_eqbound_dz = -.5,
                                     high_eqbound_dz = .5,
                                     alpha = .05, plot = TRUE, verbose = TRUE)

tost_l3_engl1_stops_el3 = TOSTpaired(n = 23, m1 = mean(english_pooled_stops$english), 
                                      m2 = mean(english_pooled_stops$l3),
                                      sd1 = sd(english_pooled_stops$english),
                                      sd2 = sd(english_pooled_stops$l3),
                                      r12 = cor(english_pooled_stops$english, english_pooled_stops$l3), 
                                      low_eqbound_dz = -.5,
                                      high_eqbound_dz = .5,
                                      alpha = .05, plot = TRUE, verbose = TRUE)


tost_l3_engl1_stops_sl3 = TOSTpaired(n = 23, m1 = mean(english_pooled_stops$l3), 
                                      m2 = mean(english_pooled_stops$spanish),
                                      sd1 = sd(english_pooled_stops$l3),
                                      sd2 = sd(english_pooled_stops$spanish),
                                      r12 = cor(english_pooled_stops$spanish, english_pooled_stops$l3), 
                                      low_eqbound_dz = -.5,
                                      high_eqbound_dz = .5,
                                      alpha = .05, plot = TRUE, verbose = TRUE)
# compiling tosts to dfs and binding for plot 
tost_l3_engl1_stops_se = (as.data.frame(tost_l3_engl1_stops_se)) %>% 
  mutate(combination = "Spanish English")

tost_l3_engl1_stops_el3 = (as.data.frame(tost_l3_engl1_stops_el3)) %>% 
  mutate(combination = "English L3")

tost_l3_engl1_stops_sl3 = (as.data.frame(tost_l3_engl1_stops_sl3)) %>% 
  mutate(combination = "Spanish L3")

all_tost_engl1_stops = rbind(tost_l3_engl1_stops_se,
                              tost_l3_engl1_stops_el3,
                              tost_l3_engl1_stops_sl3)                                   

all_tost_engl1_stops %>% 
  ggplot(aes(x = diff, y = combination)) + geom_point() + 
  geom_linerange(aes(xmin = LL_CI_TOST, xmax = UL_CI_TOST)) +
  geom_vline(xintercept = all_tost_engl1_stops$low_eqbound, linetype = "dashed") +
  geom_vline(xintercept = all_tost_engl1_stops$high_eqbound, linetype = "dashed") +
  ggtitle("English L1 stops")

sl1vowelscomb = rbind(q0_vowels_sh, q0_vowels_sf)



# non-paired TOST between L3 groups 

# Spanish l1 vowels
tost_L3_spanv = TOSTtwo(m1 = mean(q0_vowels_sh$l3), m2 = mean(q0_vowels_sf$l3), 
                    sd1 = sd(q0_vowels_sh$l3), sd2 = sd(q0_vowels_sf$l3), 
                    n1 = 28, n2 = 17, 
                    low_eqbound_d = -.5, 
                    high_eqbound_d = .5, 
                    alpha = 0.05,
                    var.equal = FALSE)
# Spanish l1 stops
tost_L3_spans = TOSTtwo(m1 = mean(q0_stops_sh$l3), m2 = mean(q0_stops_sf$l3), 
                        sd1 = sd(q0_stops_sh$l3), sd2 = sd(q0_stops_sf$l3), 
                        n1 = 29, n2 = 17, 
                        low_eqbound_d = -.5, 
                        high_eqbound_d = .5, 
                        alpha = 0.05,
                        var.equal = FALSE)

# english l1 stops 
tost_L3_engs = TOSTtwo(m1 = mean(q0_stops_eh$l3), m2 = mean(q0_stops_ef$l3), 
                        sd1 = sd(q0_stops_eh$l3), sd2 = sd(q0_stops_ef$l3), 
                        n1 = 14, n2 = 9, 
                        low_eqbound_d = -.5, 
                        high_eqbound_d = .5, 
                        alpha = 0.05,
                        var.equal = FALSE)

# compiling tosts to dfs and binding for plot # EDIT
tost_L3_spanv = (as.data.frame(tost_L3_spanv)) %>% 
  mutate(combination = "Spanish L1 Vowels")

tost_L3_spans = (as.data.frame(tost_L3_spans)) %>% 
  mutate(combination = "Spanish L1 Stops")

tost_L3_engs = (as.data.frame(tost_L3_engs)) %>% 
  mutate(combination = "English L1 Stops")

all_tost_l3groups = rbind(tost_L3_spanv,
                          tost_L3_spans,
                          tost_L3_engs)                                   

all_tost_l3groups %>% 
  ggplot(aes(x = diff, y = combination)) + geom_point() + 
  geom_linerange(aes(xmin = LL_CI_TOST, xmax = UL_CI_TOST)) +
  geom_vline(xintercept = all_tost_engl1_stops$low_eqbound, linetype = "dashed") +
  geom_vline(xintercept = all_tost_engl1_stops$high_eqbound, linetype = "dashed") +
  ggtitle("Figure X: Comparison of categoriztions between L3 groups")


