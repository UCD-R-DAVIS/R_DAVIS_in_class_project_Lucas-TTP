library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

#1)

gapminder %>%
  filter(complete.cases(gapminder)) %>% 
  group_by(continent, year) %>% 
  summarize(meann = mean(lifeExp)) %>% 
  ggplot(data = ., mapping = aes(x = year, y = meann, color = continent)) +
  geom_point()

#2)
#the scale_x_log10() line of code is reducing the scale of the function. In, other words, it is focusing in the area where the points are located.
#the geom_smooth sets a trend to the points, correlating them. It also defines the correlation as a linear model (lm), a dashed line and the color blck.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + scale_x_log10() + geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +   theme_bw()

#3)
gapminder %>% 
  filter(complete.cases(gapminder), country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  group_by(country, year) %>% 
  summarize(meann = mean(lifeExp)) %>% 
  ggplot(data = ., mapping = aes(x = year, y = meann, color = country)) +
  geom_jitter() + geom_boxplot() + 
  ggtitle("Life Expectancy of Five Countries") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Country") + ylab("Life Expectancy") 
