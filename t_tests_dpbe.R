# t-tests for DPBE 

### not sig for non-group 
no_dpbe_ppts = f %>%
  filter(extra_result == "No DPBE")

t.test(no_dpbe_ppts$span_co, no_dpbe_ppts$eng_co, paired = TRUE)


### not sig for DPBE due to 13 ppts with wrong descriptive direction  
dpbe_ppts = f %>%
  filter(extra_result != "No DPBE")

t.test(dpbe_ppts$span_co, dpbe_ppts$eng_co, paired = TRUE)

### Isolating the other 17 shows a boundary effect 
dpbe_ppts_cd = f %>%
  filter(extra_result != "No DPBE") %>% 
  filter(direction_correct == 1)

t.test(dpbe_ppts_cd$span_co, dpbe_ppts_cd$eng_co, paired = TRUE)

mean(dpbe_ppts_cd$eng_co)
mean(dpbe_ppts_cd$span_co)




