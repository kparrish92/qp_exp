dpbe_ppts_sp = f %>%
  filter(extra_result == "English boundary")

dpbe_ppts_sp %>% 
  pivot_longer(cols = 1:3, names_to = "language", values_to = "co") %>% 
  group_by(language) %>% 
  summarise(mean_co = mean(co), sd_co = sd(co))

df_long = dpbe_ppts_sp %>% 
  pivot_longer(cols = 1:3, names_to = "language", values_to = "co")

df_long %>% 
  group_by(language) %>% 
  summarize(mean_co = mean(co))

df_long$language = as.factor(df_long$language)
df_long$language = relevel(df_long$language, ref = "h_co")

b_model = brms::brm(co ~ language + (language | participant), data = df_long)

## Add L1 group and L3 group as fixed effects 


summary(b_model)

bayesplot::mcmc_areas(b_model, pars = c("b_languagespan_co", "b_languageeng_co"))


coef(b_model)[["participant"]]
