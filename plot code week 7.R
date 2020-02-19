library(tidyverse)
library(spotifyr)

happy_tunes <- get_playlist_audio_features('spotify', '37i9dQZF1DX9u7XXOp0l5L')
happy_hits <- get_playlist_audio_features('spotify', '37i9dQZF1DXdPec7aLTmlC')
happy_pop<- get_playlist_audio_features('spotify', '37i9dQZF1DX1H4LbvY4OJi')
life_sucks<- get_playlist_audio_features('spotify', '37i9dQZF1DX3YSRoSdA634')
sad_songs<- get_playlist_audio_features('spotify','37i9dQZF1DX7qK8ma5wgG1')

happy_playlists <-
  happy_tunes %>% mutate(playlist = "Happy Tunes") %>%
  bind_rows(happy_hits %>% mutate(playlist = "Happy hits"))%>%
  bind_rows(happy_pop %>% mutate(playlist = "Happy pop"))

opposite_playlists <-
  life_sucks %>% mutate(playlist = "Life sucks") %>%
  bind_rows(sad_songs %>% mutate(playlist = "Sad songs"))

Happy_Sad <-
  happy_playlists %>% mutate(playlist = "Happy playlists") %>%
  bind_rows(opposite_playlists %>% mutate(playlist = "Opposite playlists"))

Happy_Sad %>%                       # Start with awards.
  mutate(
    mode = ifelse(mode == 0, 'Minor', 'Major')
  ) %>%
  ggplot(                      # Set up the plot.
    aes(
      x = valence,
      y = energy,
      size = liveness,
      colour = mode
    )
  ) +
  geom_point() +               # Scatter plot.
  facet_wrap(~ playlist) +     # Separate charts per playlist.
  scale_x_continuous(          # Fine-tune the x axis.
    limits = c(0, 1),
    breaks = c(0, 0.50, 1),  # Use grid-lines for quadrants only.
    minor_breaks = NULL      # Remove 'minor' grid-lines.
  ) +
  scale_y_continuous(          # Fine-tune the y axis in the same way.
    limits = c(0, 1),
    breaks = c(0, 0.25, 0.50,0.75, 1),
    minor_breaks = NULL
  ) +
  scale_colour_brewer(         # Use the Color Brewer to choose a palette.
    type = "qual",           # Qualitative set.
    palette = "Paired"       # Name of the palette is 'Paired'.
  ) +
  scale_size_continuous(       # Fine-tune the sizes of each point.
    trans = "exp",           # Use an exp transformation to emphasise loud.
    guide = "none"           # Remove the legend for size.
  ) +
  theme_light() +              # Use a simpler them.
  labs(                        # Make the titles nice.
    x = "Valence",
    y = "Energy",
    colour = "Mode"
  )+
  ggtitle('Valence, energy, liveness and mode')

