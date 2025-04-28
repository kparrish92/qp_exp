source(here("scripts_2", "00_functions.R"))


lang = "hungarian"
step_for_eq = 3

h = generate_categories("hungarian", 1)
f = generate_categories("french", 1)








e = co_df_bind %>% 
  left_join(l1s, by = "participant") %>% 
  filter(is.na(extra_result)) %>% 
  group_by(result, l1) %>% 
  summarise(n = n())

r = co_df_bind %>% 
  left_join(l1s, by = "participant") %>% 
  filter(!is.na(extra_result)) %>% 
  group_by(extra_result, l1) %>% 
  summarise(n = n()) %>% 
  rename("result" = "extra_result")

er = rbind(e,r)

sum(er$n)

er %>% 
  ggplot(aes(x = result, y = n, fill = l1)) + geom_col(color = "black", position = "dodge") + facet_wrap(~l1)

er %>% 
  ggplot(aes(x = result, y = n)) + geom_col(color = "black", position = "dodge") 

co_df_bind %>% 
  write.csv(here("data", "new_tidy", "ppt_categories_h.csv"))

# great example: 5b77869d338a9300015468cf 

