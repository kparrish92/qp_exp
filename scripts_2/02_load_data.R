
stops_remove = c("5b67bffa9ed653000189ff3c", "5d159d0a8078020016aa60b9", "5d3df88c6a5b1e0001a91d8d",
                 "5dab79a5525a7600139cd31e", "5e9546ebbc08e21354f19f4d", "5ec5a561c1172f5f55cfb425",
                 "5ed39d114858d002a0691781", "5ef34cc943115906d6aa397f", "5f5f5013f947f6000bd8ddcb",
                 "5fa0bf0afbd42f13cf56e987", "5fad49057daf5f0162284e86", "5fd529f2c346b034c758c278", 
                 "5c8be0dd542fbd0016924f5f", "5cf83992bab656000198a9c6", "5ec28db2622c500632dc95bc", 
                 "5f174566f589920a8ba7e2df", "5f3344917a7a0b159bd0c375", "5f4056738318181904984b01", 
                 "5fe1788f2178d1c1b4af5bbd", "5fe92ffe2c2ee638b14a6d29", "5f00962ef7b0241ae371d912",
                 "5d4cc624ae079c0019f544b6")


desc_prof = read.csv(here("data", "tidy", "co_df_prof.csv")) %>% 
  dplyr::select(participant, score) %>% 
  unique()

two_afc_data = read.csv(here("data", "tidy", "all_2afc.csv")) %>% 
#  filter(exp == "stops") %>% 
  left_join(desc_prof, by = "participant") %>% 
  filter(!participant %in% stops_remove) %>% 
  mutate(vot = step_cont) %>% 
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
