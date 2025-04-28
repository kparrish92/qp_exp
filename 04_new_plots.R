library(here)
library(tidyverse)
source(here::here("scripts_2", "00_functions.R"))
source(here("scripts_2", "02_load_data.R"))


h_s = generate_categories("hungarian", 1, "stops") %>% 
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0)) %>% 
  mutate(l3 = "Hungarian")
f_s = generate_categories("french", 1, "stops") %>% 
  mutate(direction_correct = ifelse(eng_co > span_co, 1, 0)) %>% 
  mutate(l3 = "French") 


f = rbind(h_s, f_s) %>% replace_na(list(extra_result = "outside_both"))

f %>%
  group_by(extra_result) %>% 
  summarize(n = n())


showtext_auto()
showtext_opts(dpi = 300)

f %>%
  filter(extra_result != "No DPBE") %>%
  group_by(l1, l3) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = l1, y = n, fill = l3)) +
  geom_col(position = "dodge", color = "black") +
  geom_text(aes(label = n), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_fill_discrete(name = NULL) +  # Remove legend title
  goodale_theme() +
  xlab("L1") +
  theme(
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank()
  )

ggsave(here("new_docs", "img", "dpbe_ppts.png"))


dpbe_ppts = f %>%
  filter(extra_result != "No DPBE")

data_e_s = two_afc_data %>% filter(language == "english" | language == "spanish") %>% 
  filter(exp == "stops") %>% filter(participant %in% dpbe_ppts$participant)

model_e_s <- lme4::glmer(response ~ step_cont * language + (language | participant), family = binomial(link = "logit"), 
  data = data_e_s)
# report model
summary(model_e_s)

# report desc cross-overs 
mean(dpbe_ppts$span_co)
sd(dpbe_ppts$span_co)

mean(dpbe_ppts$eng_co)
sd(dpbe_ppts$eng_co)


## Eng-span 

no_dpbe_ppts = f %>%
  filter(extra_result == "No DPBE")

data_e_s_nb = two_afc_data %>% filter(language == "english" | language == "spanish") %>% 
  filter(exp == "stops") %>% filter(participant %in% no_dpbe_ppts$participant)

model_e_s_nb <- glm(response ~ step_cont * language, family = binomial(link = "logit"), 
                 data = data_e_s_nb)

# report model
summary(model_e_s_nb)


two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% dpbe_ppts$participant) %>% 
  filter(Language == "Spanish" | Language == "English") %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed")


ggsave(here("new_docs", "img", "dpbe_ppts_s.png"))

two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% no_dpbe_ppts$participant) %>% 
  filter(Language == "Spanish" | Language == "English") %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed")

ggsave(here("new_docs", "img", "dpbe_no_ppts_s.png"))

f %>%
  group_by(extra_result, l1, l3) %>% 
  summarize(n = n()) %>% 
  filter(extra_result == "Spanish boundary") %>% 
  ggplot(aes(x = l1, y = n, fill = l3)) + 
  geom_col(position = "dodge", color = "black") +
  geom_text(aes(label = n), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_fill_discrete(name = NULL) +  # Remove legend title
  goodale_theme() +
  xlab("L1") +
  theme(
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank()
  )

ggsave(here("new_docs", "img", "dpbe_span_ppts.png"))



dpbe_ppts_sp = f %>%
  filter(extra_result == "Spanish boundary")

mean(dpbe_ppts_sp$span_co)
sd(dpbe_ppts_sp$span_co)

mean(dpbe_ppts_sp$eng_co)
sd(dpbe_ppts_sp$eng_co)

t.test(dpbe_ppts_sp$span_co, dpbe_ppts_sp$eng_co, paired = TRUE)



two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% dpbe_ppts_sp$participant) %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed")


ggsave(here("new_docs", "img", "dpbe_ppts_sb.png"))




f %>%
  group_by(extra_result, l1, l3) %>% 
  summarize(n = n()) %>% 
  filter(extra_result == "English boundary") %>% 
  ggplot(aes(x = l1, y = n, fill = l3)) + 
  geom_col(position = "dodge", color = "black") +
  geom_text(aes(label = n), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_fill_discrete(name = NULL) +  # Remove legend title
  goodale_theme() +
  xlab("L1") +
  theme(
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank()
  )

ggsave(here("new_docs", "img", "dpbe_eng_ppts.png"))

dpbe_ppts_en = f %>%
  filter(extra_result == "English boundary")

two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% dpbe_ppts_en$participant) %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed")


ggsave(here("new_docs", "img", "dpbe_ppts_eng.png"))

two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% dpbe_ppts_en$participant) %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed") + facet_wrap(~participant)

ggsave(here("new_docs", "img", "dpbe_ppts_eng_ind.png"))


f %>%
  group_by(extra_result, l1, l3) %>% 
  summarize(n = n()) %>% 
  filter(extra_result == "outside_both") %>% 
  ggplot(aes(x = l1, y = n, fill = l3)) + 
  geom_col(position = "dodge", color = "black") +
  geom_text(aes(label = n), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_fill_discrete(name = NULL) +  # Remove legend title
  goodale_theme() +
  xlab("L1") +
  theme(
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank()
  )

ggsave(here("new_docs", "img", "na_bar_ppts.png"))

dpbe_ppts_na = f %>%
  filter(extra_result == "outside_both")

two_afc_data %>% 
  mutate(Language = case_when(
    language == "english" ~ "English",
    language == "spanish" ~ "Spanish",
    language == "hungarian" ~ "L3",
    language == "french" ~ "L3",
  )) %>% 
  filter(exp == "stops") %>% 
  filter(participant %in% dpbe_ppts_na$participant) %>% 
  ggplot(aes(x = step_cont, y = response, color = Language)) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  goodale_theme() + xlab("Contimuum Step") + ylab("Probability of /p/ response") +
  geom_hline(yintercept = .5, linetype = "dashed") + facet_wrap(~participant)


ggsave(here("new_docs", "img", "na_ppts_s.png"))








######
