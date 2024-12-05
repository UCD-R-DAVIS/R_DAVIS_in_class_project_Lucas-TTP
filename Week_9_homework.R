library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")

structure(surveys)

for(n in unique(surveys$taxa)){
  taxon <- surveys[surveys$taxa == n,]
  longestnames <- taxon[nchar(taxon$species) == max(nchar(taxon$species)),] %>% select(species)
  print(paste0("The longest species name among ", n, " taxonomy is/are: "))
  print(unique(longestnames$species))
}

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

cols <- mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
cols %>% map(max, na.rm = T)

C_to_F <- function(x){
  x * 1.8 + 32
}
mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)


mloa

#Bonus:
mloa %>% select(c("temp_C_2m", "temp_C_10m", "temp_C_towertop")) %>% map_df(C_to_F) %>% rename("temp_F_2m"="temp_C_2m", "temp_F_10m"="temp_C_10m", "temp_F_towertop"="temp_C_towertop") %>% cbind(mloa)



