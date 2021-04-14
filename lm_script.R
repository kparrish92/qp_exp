
## The Linear Regression Model 

Based on the results of the t-tests, a post-hoc general linear model was run for the Spanish L1 group vowels. The dependent variable for the model was the L3 crossover boundary, and the predictors were the L1 crossover boundary, the L2 crossover boundary and L3 group. Nested model comparisons were carried out in order to determine the best fitting model (`r model_svowels2$estimate$modelfit$r2`). The results of nested model comparisons revealed a main effect of L1(), of L2(), and an L1*L2 interaction(), meaning that these values were predictors of the L3 crossover. There was 

```{r}

vowels_model_e <- apa_print(model_evowels2)
vowels_model_s <- apa_print(model_svowels2)
stops_model_e <- apa_print(model_estops2)
stops_model_s <- apa_print(model_sstops2)
summary(vowels_model_e)
summary(vowels_model_s)
summary(stops_model_e)
summary(stops_model_s)
```

```{r}
apa_table(
  vowels_model_e$table
  , caption = "Vowel Model English L1 group"
)

apa_table(
  vowels_model_s$table
  , caption = "Vowel Model Spanish L1 group"
)


apa_table(
  stops_model_e$table
  , caption = "Stops Model English L1 group"
)


apa_table(
  stops_model_s$table
  , caption = "Stops Model Spanish L1 group"
)


```
