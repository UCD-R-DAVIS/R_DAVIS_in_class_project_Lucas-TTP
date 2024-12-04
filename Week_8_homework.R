#loading tidyverse
library(tidyverse)

#loading lubridate
library(lubridate)

#downloading dataset
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

structure(mloa)
summary(mloa)

# Removing NA
mloa2 = mloa %>%
filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  # Creating column "datetime"
  mutate(datetime = ymd_hm(paste0(year,"-",
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), 
                           tz = "UTC")) %>%
  # Using mutate to Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

summary(mloa2$datetimeLocal)
with_tz(mloa2)

# Extracting month and hour from local time column
mloa2 %>%
  mutate(localMon = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  # Group by local month and hour
  group_by(localMon, localHour) %>%
  # Calculate mean temperature
  summarize(meantemp = mean(temp_C_2m)) %>%
  # Plot
  ggplot(aes(x = localMon,
             y = meantemp)) +
  # Color points by local hour
  geom_point(aes(col = localHour)) +
  # Selecting a color ramp
  scale_color_viridis_c(option = "plasma") +
  # Labeling axes, add a theme
  xlab("Month") +
  ylab(" mean hourly temperature (in degrees C)") +
  theme_classic()