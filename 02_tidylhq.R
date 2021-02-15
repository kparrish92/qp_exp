## Tidy lhq

lhq1 = read.csv("./raw_data/lhq/LHQ 3.0 raw result (1).csv")
lhq2 = read.csv("./raw_data/lhq/LHQ 3.0 raw result (2).csv")
lhq3 = read.csv("./raw_data/lhq/LHQ 3.0 raw result (3).csv")
lhq5 = read.csv("./raw_data/lhq/LHQ 3.0 raw result (5).csv")

colnames(lhq2)[9] <- "L1"
colnames(lhq2)[15] <- "L2"
colnames(lhq2)[1] <- "participant"
colnames(lhq2)[2] <- "prolific"

colnames(lhq1)[9] <- "L1"
colnames(lhq1)[15] <- "L2"
colnames(lhq1)[1] <- "participant"
colnames(lhq1)[2] <- "prolific"


colnames(lhq3)[9] <- "L1"
colnames(lhq3)[15] <- "L2"
colnames(lhq3)[1] <- "participant"
colnames(lhq3)[2] <- "prolific"

colnames(lhq5)[9] <- "L1"
colnames(lhq5)[15] <- "L2"
colnames(lhq5)[1] <- "participant"
colnames(lhq5)[2] <- "prolific"

lhq2 = lhq2 %>% 
  select(L1, L2, participant, prolific)
lhq1 = lhq1 %>% 
  select(L1, L2, participant, prolific)
lhq3 = lhq3 %>% 
  select(L1, L2, participant, prolific)
lhq5 = lhq5 %>% 
  select(L1, L2, participant, prolific)

lhq = rbind(lhq1, lhq2, lhq3, lhq5)


all_stops = left_join(all_stops, lhq, by = "participant")
all_vowels = left_join(all_vowels, lhq, by = "participant")

all_stops = all_stops %>% 
  mutate(group = if_else(L2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group)) 

all_vowels = all_vowels %>% 
  mutate(group = if_else(L2 == "Spanish", "ES", "SE")) %>% 
  filter(!is.na(group))

all_vowels_se = all_vowels %>% 
  filter(group == "SE")

all_stops_se = all_stops %>% 
  filter(group == "SE")

all_vowels_es = all_vowels %>% 
  filter(group == "ES")

all_stops_es = all_stops %>% 
  filter(group == "ES")
