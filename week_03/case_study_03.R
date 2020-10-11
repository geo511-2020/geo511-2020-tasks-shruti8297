install.packages("gapminder")
library("gapminder")
library(dplyr)
data(gapminder)
x <-gapminder %>% 
  filter(!(country %in% "Kuwait"))
ggplot(x, aes(x=lifeExp, y= gdpPercap, color=continent, size=pop/100000))+
  geom_point()+
  facet_wrap(~year,,nrow=1)+
  theme_bw()+
  labs(x="Life Expectency", y="GDP Per Capita", color="Continent", size="Population (100K)")+
  scale_y_continuous(trans = "sqrt")

data(gapminder)
data_1 <- gapminder %>%
  group_by(continent, year)%>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), pop = sum(as.numeric(pop)))
ggplot() +
  geom_line(data=gapminder,aes(x=year, y=gdpPercap,color=continent, group=country))+
  geom_point(data=gapminder,aes(x=year, y=gdpPercap,color=continent))+
  geom_line(data=data_1, aes(x=year, y= gdpPercapweighted))+
  geom_point(data=data_1, aes(x=year, y= gdpPercapweighted, size=pop/100000))+
  ylim(0, 50000)+
  facet_wrap(~continent)+
  theme_bw()+
  labs(x="Year", y="GDP Per Capita", color="Continent", size="Population (100K)")
