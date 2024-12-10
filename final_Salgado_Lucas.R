library(tidyverse)
# reading dataframe
tyle <- "https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv"

tyler <- read_csv(tyle)

#converting from character to factor
tyler$sport <- factor(tyler$sport)

class(tyler$sport)

#filtering and classifying per period
tyler_run <- tyler %>% 
  filter(sport == "running") %>%
  filter(total_elapsed_time_s >= 60) %>%
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>% 
  mutate(season = case_when(year < 2024 ~ 'pre-2024',
                       year > 2023  & month <= (6) ~ 'first_efforts',
                       year > 2023 & month > (6) ~ 'athlete'))

structure(tyler_run)
summary(tyler_run$minutes_per_mile)

#Creating the graph
ggplot(data = tyler_run, aes(x = minutes_per_mile, y = steps_per_minute, color = season)) +
  geom_point(alpha = 0.5, size = 2) +  
  facet_wrap(~ season) + #modifying the graph with aes
  labs(
    title = "Strides Per Minute (SPM) vs Speed",
    x = "Speed",
    y = "SPM",
    color = "Season"
  ) +
  theme_minimal() +                  # theme
  theme(
    legend.position = "bottom",      # Positioning legend at the bottom
    plot.title = element_text(hjust = 0.5)  # Centering the title
  )


#Alternative code with trendlines -> added a row with geom_smooth
ggplot(data = tyler_run, aes(x = minutes_per_mile, y = steps_per_minute, color = season)) +
  geom_point(alpha = 0.5, size = 2) +  
  geom_smooth(method = "lm", se = FALSE, aes(color = season)) +  #Adding linear trendlines
  facet_wrap(~ season) +
  labs(
    title = "Strides Per Minute (SPM) vs Speed with Trendlines",
    x = "Speed",
    y = "Strides Per Minute (SPM)",
    color = "Season"
  ) +
  theme_minimal() +                  # theme
  theme(
    legend.position = "bottom",      # legend at the bottom
    plot.title = element_text(hjust = 0.5)  #Centering the title
  )