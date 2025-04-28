library(tidyverse)
library(igraph)
library(showtext)
library(rcartocolor)

goldilocks <- tibble(from = c("61 total participants", "61 total participants",
                              "30 English-Spanish DPBE", "30 English-Spanish DPBE",
                              "30 English-Spanish DPBE"),
                     to = c("31 no English-Spanish effect", "30 English-Spanish DPBE",
                            "19 Spanish-like L3 boundary", "6 English-like L3 boundary", "5 neither"))

g = graph_from_data_frame(goldilocks, directed = TRUE)
coords = layout_as_tree(g)
colnames(coords) = c("x", "y")

output_df = as_tibble(coords) %>%
  mutate(step = vertex_attr(g, "name"),
         label = gsub("\\d+$", "", step),
         x = x*-1,
         type = factor(c(1)))

plot_nodes = output_df %>%
  mutate(xmin = x - 0.35,
         xmax = x + 0.35,
         ymin = y - 0.25,
         ymax = y + 0.25)


plot_edges = goldilocks %>%
  mutate(id = row_number()) %>%
  pivot_longer(cols = c("from", "to"),
               names_to = "s_e",
               values_to = "step") %>%
  left_join(plot_nodes, by = "step") %>%
  select(-c(label, type, y, xmin, xmax)) %>%
  mutate(y = ifelse(s_e == "from", ymin, ymax)) %>%
  select(-c(ymin, ymax))

p = ggplot() +
  geom_rect(data = plot_nodes,
            mapping = aes(xmin = xmin, ymin = ymin, 
                          xmax = xmax, ymax = ymax, 
                          ),
            alpha = 0.5, fill = "white", colour = "black") 



font_add_google(name = "Open Sans", family = "Open Sans")
showtext_auto()

p = p + 
  geom_text(data = plot_nodes,
            mapping = aes(x = x, y = y, label = label),
            family = "Open Sans") 

p = p + 
  geom_path(data = plot_edges,
            mapping = aes(x = x, y = y, group = id),
            arrow = arrow(length = unit(0.3, "cm"), type = "closed"))


p + 
  theme_void() +
  theme(plot.margin = unit(c(1, 1, 0.5, 1), "cm"),
        legend.position = "none") 

ggsave(here("new_docs", "img", "flow_chart.png"))
