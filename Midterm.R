#Read in the file tyler_activity_laps_10-24.csv from the class github page. This file is at url https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.
library(tidyverse) 

tyler_actvity_laps_10_24 <- "https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv"

tyler_activity <- read_csv(tyler_actvity_laps_10_24)

str(tyler_activity)
#Filter out any non-running activities.

tyler_activity$sport <- as_factor(tyler_activity$sport)

tyler_running <- tyler_activity %>% 
  filter(sport == "running")

summary(tyler_running$sport)


#Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.
str(tyler_running$minutes_per_mile)

tyler_running_10min <- tyler_running %>%
  filter(total_elapsed_time_s >= 60) %>%  
  filter(minutes_per_mile < 10 & minutes_per_mile > 5)


summary(tyler_running_10min$minutes_per_mile)
#Create a new categorical variable, pace, that categorizes laps by pace: “fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). Create a second categorical variable, form that distinguishes between laps run in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all prior years (“old”).
tyler_categorical <- tyler_running_10min %>% 
  mutate(laps_by_pace = case_when(
    minutes_per_mile < 6 ~ "fast",
    minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
    T ~ "slow"),
    year_categorical = case_when(
        year== 2024 ~ "new",
        T ~ "old"))
        
        
str(tyler_categorical$minutes_per_mile)
str(tyler_categorical$laps_by_pace)
summary(tyler_categorical)
#Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. Make sure that slow speed is the second column, medium speed is the third column, and fast speed is the fourth column (hint: think about what the select() function does).
str(tyler_categorical)

tyler_avg <- tyler_categorical %>% 
  group_by(year_categorical, laps_by_pace) %>% 
  summarize(avg_time = mean(steps_per_minute)) %>%
  pivot_wider(id_cols = year_categorical, names_from = laps_by_pace,  values_from = avg_time) %>%
  select(year_categorical,slow,medium,fast)

tyler_avg

#Finally, Tyler thinks he’s been doing better since July after the doctors filmed him running again and provided new advice. Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.
tyler_summary <- tyler_categorical %>% 
  filter(year_categorical == "new") %>% 
  mutate(monthS = case_when(
    month<=6 ~ "jan_jun",
    month>6 & month<=10 ~ "jul-oct",
    T~"others")) %>% 
  group_by(monthS) %>% 
  summarize(min1 = min(steps_per_minute), 
            mean1= mean(steps_per_minute),
            median1= median(steps_per_minute),
            max1= max(steps_per_minute))
tyler_summary
