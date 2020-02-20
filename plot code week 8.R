library(spotifyr)
library(tidyverse)
library(ggplot2)

Sys.setenv(SPOTIFY_CLIENT_ID = '3acf5bc3d46145ecb9873e98d17351fb')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '9bd775622ebe43db91f9a040ba5bf9c3')

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

ggplot(happy_tunes, aes(x=key))+
  geom_bar(fill='lightpink')+
  theme_classic()


ggplot(happy_pop, aes(x=key))+
  geom_bar(fill='lightcoral')+
  theme_classic()


ggplot(happy_hits, aes(x=key))+
  geom_bar(fill='lightpink3')+
  theme_classic()

ggplot(happy_playlists, aes(x=key))+
  geom_bar()+
  theme_classic()