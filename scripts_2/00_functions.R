# Create function to fit many models
fit_one_mod <- function(data, elog = FALSE) {
  if (elog == FALSE) {
    mod <- glm(
      response ~ step_cont, 
      data = data, 
      family = binomial(link = "logit")
    )
    return(mod)
  } else {
    mod <- lm(
      eLog ~ step_std, 
      weights = wts, 
      data = data 
    )
    return(mod)
  }
}

calculate_co = function(m)
{  
  intercept = coef(m)[1]
  slope = coef(m)[2]
  co = intercept/slope*-1
  return(co)
}

generate_categories <- function(lang, step_for_eq, seg) {
  
  two_afc_data_h = two_afc_data %>% 
    filter(exp == seg) %>% 
    filter(language == lang)
    
  
  p_list = unique(two_afc_data_h$participant)
  
  co_df_list = list()
  
  for (i in 1:length(p_list)) {
    
    p = p_list[i]
    
    two_afc_data %>% 
      filter(exp == seg) %>% 
      filter(participant == p) %>% 
      ggplot(aes(x = step_cont, y = response, color = language)) + 
      geom_smooth(method = "glm", method.args = list(family = "binomial"))
    
    
    dfh = two_afc_data %>% 
      filter(exp == seg) %>% 
      filter(participant == p) %>% 
      filter(language == lang)
    
    mh = fit_one_mod(dfh)
    h_co = calculate_co(m = mh)
    
    dfe = two_afc_data %>% 
      filter(exp == seg) %>% 
      filter(participant == p) %>% 
      filter(language == "english")
    
    me = fit_one_mod(dfe)
    eng_co = calculate_co(m = me)
    
    dfs = two_afc_data %>% 
      filter(exp == seg) %>% 
      filter(participant == p) %>% 
      filter(language == "spanish")
    
    se = fit_one_mod(dfs)
    span_co = calculate_co(m = se)
    
    co_df = data.frame(span_co, eng_co, h_co, participant = p_list[i])
    co_df_list[[i]] = co_df
  }
  
  l1s = two_afc_data %>% 
    dplyr::select(participant, l1) %>% 
    unique()
  
  co_df_bind = do.call(rbind, co_df_list) %>% 
    mutate(result = 
             case_when(span_co < h_co & h_co < eng_co ~ "Intermediate L3",
                       span_co > h_co & h_co > eng_co ~ "Intermediate L3",
                       span_co < h_co & eng_co < h_co ~ "Outside both",
                       span_co > h_co & eng_co > h_co ~ "Outside both")) %>% 
    mutate(extra_result = case_when(
      abs(span_co - eng_co) < step_for_eq ~ "No DPBE",
      abs(span_co - h_co) < step_for_eq ~ "Spanish boundary",
      abs(eng_co - h_co) < step_for_eq ~ "English boundary")) %>% 
    left_join(l1s, by = "participant")
  
  return(co_df_bind)
}


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
  
  sig_eng_me = ifelse(s_mod[3,4] < .05, 1, 0)
  sig_sp_l3_me = ifelse(s_mod[4,4] < .05, 1, 0)
  sig_step_eng_int = ifelse(s_mod[5,4] < .05, 1, 0) # if the effect was distinct per language
  sig_step_l3_sp_int = ifelse(s_mod[6,4] < .05, 1, 0)  # if the effect was distinct per language
  
  ## English reference model
  e_ref = summary(model_e)[["coefficients"]]
  
  sig_sp_me = ifelse(e_ref[3,4] < .05, 1, 0)
  sig_eng_l3_me = ifelse(e_ref[4,4] < .05, 1, 0)
  sig_step_span_int = ifelse(e_ref[5,4] < .05, 1, 0)
  sig_step_l3_eng_int = ifelse(e_ref[6,4] < .05, 1, 0)
  
  results_df = data.frame(sig_eng_me, sig_sp_l3_me, sig_step_eng_int, sig_step_l3_sp_int,
                          sig_sp_me, sig_eng_l3_me, sig_step_span_int, sig_step_l3_eng_int) %>% 
    mutate(dpbe = ifelse(sig_eng_me == 1 & sig_step_eng_int == 1, 1, 0)) %>% 
    mutate(eng_like_l3 = ifelse(sig_eng_l3_me == 0 & sig_step_l3_eng_int == 0, 1, 0)) %>% 
    mutate(span_like_l3 = ifelse(sig_sp_l3_me == 0 & sig_step_l3_sp_int == 0, 1, 0)) 
  
  
  return(results_df)
}

goodale_theme <- function() {
  theme(
    # add border 1)
    # color background 2)
    panel.background = element_rect(fill = "white"),
    
    
    #  panel.grid.major.x = element_line(colour = "black", linetype = 2, size = 0.2),
    #panel.grid.minor.x = element_blank(),
    #    panel.grid.major.y =  element_line(colour = "black", linetype = 2, size = 0.2),
    # panel.grid.minor.y = element_blank(),
    #
    # modify grid 3)
    # modify text, axis and colour 4) and 5)
    axis.text = element_text(colour = "black", family = "Times New Roman", size = 12),
    axis.title = element_text(colour = "black", family = "Times New Roman", size = 12),
    # legend at the bottom 6)
    legend.position = "bottom",
    legend.title = element_text(colour = "black", family = "Times New Roman", size = 12),
    legend.text = element_text(colour = "black", family = "Times New Roman", size = 12)
  )
} 



goodale_theme <- function() {
  theme(
    panel.background = element_rect(fill = "white"),
    axis.text = element_text(colour = "black", family = "Times New Roman", size = 12),
    axis.title = element_text(colour = "black", family = "Times New Roman", size = 12),
    legend.position = "bottom",
    legend.title = element_text(colour = "black", family = "Times New Roman", size = 12),
    legend.text = element_text(colour = "black", family = "Times New Roman", size = 12)
  )
} 

syrett_theme <- function() {
  theme(
    axis.text = element_text(colour = "black", family = "Arial", size = 12),
    axis.title = element_text(colour = "black", family = "Arial", size = 12))
} 
