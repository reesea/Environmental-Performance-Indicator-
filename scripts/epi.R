# Load packages
require(dplyr)
require(plotly)

# Read in data
setwd("E:/epi/data")
epi <- readxl::read_xlsx("2016-epi.xlsx", sheet = 3)

# View data
View(epi)
dim(epi)
head(epi)
tail(epi)
xtabs(~Country, epi)
str(epi)

# Data Preprocessing
names(epi)[names(epi) == 'Country'] <- 
  'country'
names(epi)[names(epi) == '2016 EPI Score'] <- 
  'epi_score'
names(epi)[names(epi) == 'Environmental Health'] <- 
  'environmental_health'
names(epi)[names(epi) == 'EH - Health Impacts'] <- 
  'health_impacts'
names(epi)[names(epi) == 'EH - Air Quality'] <- 
  'air_quality'
names(epi)[names(epi) == 'EV - Water Resources']<- 
  'water_resources'
names(epi)[names(epi) == 'Household Air Quality'] <- 
  'household_air_quality'
names(epi)[names(epi) == 'Access to Sanitation'] <- 
  'access_to_sanitation'
names(epi)[names(epi) == 'Access to Drinking Water'] <- 
  'access_to_drinking_water'
names(epi)[names(epi) == 'Wastewater Treatment'] <- 
  'wastewater_treatment'

epi <- epi[c(-1,-3,-5,-7,-10,-12,-13,-14,-15,-16,-17,-19,-20,-21,-22,
             -23,-25,-27,-29,-30,-31,-32,-33,-34,-35,-36,-37,-38,
             -39,-40)]

# Structure of the data
str(epi)

# Summary of the data
summary(epi)


epi.plot = ggplot(epi, aes(x = air_quality, y = health_impacts)) +
  geom_point() +
  geom_smooth(method="lm", color = "red")
epi.plot

epi.plot = ggplot(epi, aes(x = air_quality, 
                           y = environmental_health)) +
  geom_point() +
  geom_smooth(method="lm", color = "blue")
epi.plot

plot(epi$air_quality, epi$health_impacts, xlab = "air_quality", 
     ylab = "health_impacts", 
     main = "Air and Health Performance", 
     abline(lm(epi$health_impacts ~ epi$air_quality)))

boxplot(epi$air_quality, epi$environmental_health)
boxplot(epi$air_quality, epi$health_impacts)

p <- plot_ly(data = epi, x = ~air_quality, y = ~environmental_health,
             marker = list(size = 10,
                           color = 'rgba(255, 182, 193, .9)',
                           line = list(color = 'rgba(152, 0, 0, .8)',
                                       width = 2))) %>%
  layout(title = 'Styled Scatter',
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE))
p
