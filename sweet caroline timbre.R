```{r}

sweet_caroline <- get_track_audio_features('3298yRJKPcCndQdNiTZKIo')

sc <- 
  get_tidy_audio_analysis('3298yRJKPcCndQdNiTZKIo') %>% 
  compmus_align(bars, segments) %>% 
  select(bars) %>% unnest(bars) %>% 
  mutate(
    pitches = 
      map(segments, 
          compmus_summarise, pitches, 
          method = 'rms', norm = 'euclidean')) %>% 
  mutate(
    timbre = 
      map(segments, 
          compmus_summarise, timbre, 
          method = 'mean'))
```