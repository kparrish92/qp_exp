stops_remove = c("5b67bffa9ed653000189ff3c", "5d159d0a8078020016aa60b9", "5d3df88c6a5b1e0001a91d8d",
                 "5dab79a5525a7600139cd31e", "5e9546ebbc08e21354f19f4d", "5ec5a561c1172f5f55cfb425",
                 "5ed39d114858d002a0691781", "5ef34cc943115906d6aa397f", "5f5f5013f947f6000bd8ddcb",
                 "5fa0bf0afbd42f13cf56e987", "5fad49057daf5f0162284e86", "5fd529f2c346b034c758c278", 
                 "5c8be0dd542fbd0016924f5f", "5cf83992bab656000198a9c6", "5ec28db2622c500632dc95bc", 
                 "5f174566f589920a8ba7e2df", "5f3344917a7a0b159bd0c375", "5f4056738318181904984b01", 
                 "5fe1788f2178d1c1b4af5bbd", "5fe92ffe2c2ee638b14a6d29", "5f00962ef7b0241ae371d912",
                 "5d4cc624ae079c0019f544b6")

two_afc_data = read.csv(here("data", "tidy", "all_2afc.csv")) %>% 
  filter(exp == "stops") %>% 
  filter(!participant %in% stops_remove) %>% 
  mutate(step_cont =
           case_when(
             step_cont == -35 ~ 1,
             step_cont == -30 ~ 2,
             step_cont == -25 ~ 3,
             step_cont == -20 ~ 4,
             step_cont == -15 ~ 5,
             step_cont == -10 ~ 1,
             step_cont == -5 ~ 7,
             step_cont == 5 ~ 8,
             step_cont == 10 ~ 9,
             step_cont == 15 ~ 10,
             step_cont == 20 ~ 11,
             step_cont == 25 ~ 12,
             step_cont == 30 ~ 13,
             step_cont == 35 ~ 14,
             step_cont == 40 ~ 15,
             step_cont == 45 ~ 16,
             step_cont == 50 ~ 17,
           ))

hungarian_group = generate_categories("hungarian", 1) %>% 
  mutate(l3_group = "Hungarian")
french_group = generate_categories("french", 1) %>% 
  mutate(l3_group = "French")

all_ppts = rbind(hungarian_group, french_group) %>%  
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0))

## correct direction, later boundary than English (eng-like but not that)
all_ppts %>% 
  filter(direction_correct == 1 & is.na(extra_result))

all_ppts %>% 
  filter(direction_correct == 1 & is.na(extra_result))


all_ppts %>% 
  filter(direction_correct == 1) %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = extra_result, x = cross_over, fill = language)) + geom_boxplot() +
  facet_wrap(~l3_group)


desc = all_ppts %>% 
  filter(direction_correct == 1) %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  group_by(extra_result, language, l3_group) %>% 
  summarize(n = n())

# Total ppts per group that had a DPBE
all_ppts %>% 
  filter(direction_correct == 1) %>% 
  group_by(l3_group) %>% 
  summarise(n = n())

# Summary of the percetage of L3 boundarie types 
desc = all_ppts %>% 
  filter(direction_correct == 1) %>% 
 # filter(extra_result != "No DPBE") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  filter(language == "h_co") %>% 
  group_by(l3_group,extra_result, l1) %>% 
  summarize(n = n()) %>% 
  mutate(pct = case_when(
    l3_group == "French" ~ n/12,
    l3_group == "Hungarian" ~ n/24
  )) 


desc %>% 
  ggplot(aes(x = extra_result, y = pct, fill = l3_group)) +
  geom_col(position = "dodge", color = "black")


dbpe_ppts = generate_categories("hungarian", 1) %>% 
  filter(extra_result == "No DPBE") 

dbpe_ppts_f = generate_categories("french", 1) %>% 
  filter(extra_result == "No DPBE") 

no_eff = rbind(dbpe_ppts, dbpe_ppts_f) %>% 
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0)) %>% 
  filter(direction_correct == 1)


h = generate_categories("hungarian", 1) %>% 
  filter(!extra_result == "No DPBE") %>% 
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0)) %>% 
  filter(direction_correct == 1)

f = generate_categories("french", 1) %>% 
  filter(!extra_result == "No DPBE") %>%
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0)) %>% 
  filter(direction_correct == 1)

all = rbind(no_eff, f, h)

all %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = extra_result, x = cross_over, fill = language)) + geom_boxplot() 

all %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  group_by(extra_result, language) %>% 
  summarize(n = n())
  

  
no_eff %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_boxplot() 

h %>% # n = 9
  filter(extra_result == "Spanish boundary") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_boxplot()

h %>% # n = 9
  filter(extra_result == "Spanish boundary") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_boxplot() + facet_wrap(~participant)

h %>% # n = 2
  filter(extra_result == "English boundary") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_point() + facet_wrap(~participant)

f %>% # n = 4
  filter(extra_result == "Spanish boundary") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_boxplot() + facet_wrap(~participant)

f %>% # n = 1
  filter(extra_result == "English boundary") %>% 
  pivot_longer(cols = 1:3,names_to = "language", values_to = "cross_over") %>%
  ggplot(aes(y = language, x = cross_over)) + geom_point() + facet_wrap(~participant)





h_model_data = two_afc_data %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% h$participant)

f_model_data = two_afc_data %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% f$participant)


h_model_data %>% 
  ggplot(aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) + facet_wrap(~l1)


f_model_data %>% 
  ggplot(aes(x = step_cont, y = response, color = language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  facet_wrap(~participant)

log_mod_b = brms::brm(response ~ step_cont*language + (language | participant), data = h_model_data, family = "bernoulli")

log_mod_f = brms::brm(response ~ step_cont*language + (language | participant), data = f_model_data, family = "bernoulli")


brms::conditional_effects(log_mod_b)


brms::conditional_effects(log_mod_f)
