
unique(two_afc_data$participant)


ppt = "5d7c7425c0d7db00187b1199"

fit_models(ppt)

fit_models = function(ppt)

{
this_data = two_afc_data %>% 
  # filter(exp == "vowels") %>% 
  filter(participant == ppt) 


## Spanish reference model
this_data$language = as.factor(this_data$language)
this_data$language = relevel(this_data$language, ref = "spanish")

model <- glm(response ~ step_cont*language, family=binomial(link='logit')
             ,data = this_data)


this_data_e = this_data

this_data_e$language = as.factor(this_data_e$language)
this_data_e$language = relevel(this_data_e$language, ref = "english")

model_e <- glm(response ~ step_cont*language, family=binomial(link='logit')
             ,data = this_data_e)

s_mod = summary(model)[["coefficients"]]

sig_eng_me = ifelse(e_mod[3,4] < .05, 1, 0)
sig_sp_l3_me = ifelse(e_mod[4,4] < .05, 1, 0)
sig_step_eng_int = ifelse(e_mod[5,4] < .05, 1, 0) # if the effect was distinct per language
sig_step_l3_sp_int = ifelse(e_mod[6,4] < .05, 1, 0)  # if the effect was distinct per language

## English reference model
e_ref = summary(model_e)[["coefficients"]]

sig_sp_me = ifelse(e_ref[3,4] < .05, 1, 0)
sig_eng_l3_me = ifelse(e_ref[4,4] < .05, 1, 0)
sig_step_span_int = ifelse(e_ref[5,4] < .05, 1, 0)
sig_step_l3_eng_int = ifelse(e_ref[6,4] < .05, 1, 0)

results_df = data.frame(sig_eng_me, sig_sp_l3_me, sig_step_eng, sig_step_eng_l3,
           sig_sp_me, sig_eng_l3_me, sig_step_span_int, sig_step_l3_eng_int) %>% 
  mutate(dpbe = ifelse(sig_eng_me == 1 & sig_step_eng == 1, 1, 0)) %>% 
  mutate(eng_like_l3 = ifelse(sig_step_span_int == 0 & sig_step_span_int == 0, 1, 0)) %>% 
  mutate(span_like_l3 = ifelse(sig_sp_l3_me == 0 & sig_step_eng_l3 == 0, 1, 0)) 


return(results_df)
}
