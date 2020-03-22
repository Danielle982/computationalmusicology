
### random forests

```{r}
happy_forest <- 
  rand_forest(mode = 'classification') %>% 
  set_engine('randomForest')
predict_forest <- function(split)
  fit(happy_forest, playlist ~ ., data = analysis(split)) %>% 
  predict(assessment(split), type = 'class') %>%
  bind_cols(assessment(split))

happy_cv %>% 
  mutate(pred = map(splits, predict_forest)) %>% 
  unnest(pred) %>% 
  metric_set(accuracy, kap, j_index)(truth = playlist, estimate = .pred_class)

happy_class %>% 
  fit(happy_forest, playlist ~ ., data = .) %>% 
  pluck('fit') %>% 
  randomForest::varImpPlot()
```

### random forests

```{r}
others_forest <- 
  rand_forest(mode = 'classification') %>% 
  set_engine('randomForest')
predict_forest <- function(split)
  fit(others_forest, playlist ~ ., data = analysis(split)) %>% 
  predict(assessment(split), type = 'class') %>%
  bind_cols(assessment(split))

others_cv %>% 
  mutate(pred = map(splits, predict_forest)) %>% 
  unnest(pred) %>% 
  metric_set(accuracy, kap, j_index)(truth = playlist, estimate = .pred_class)

others_class %>% 
  fit(others_forest, playlist ~ ., data = .) %>% 
  pluck('fit') %>% 
  randomForest::varImpPlot()
```