knitr::opts_chunk$set(echo = TRUE)

# Libraries
library(ggplot2)
library(dplyr)
library(corrplot)
library(gridExtra)
library(caret)
library(car)
library(ROCR)
library(pROC)
library(ggeffects)
library(MASS)


# ----

bike <- read.csv("C:/Users/Michele Puglia/Desktop/GLM/SeoulBikeData.csv", header = TRUE)
glimpse(bike)
summary(bike)


# ----

bike <- bike %>%
  mutate(
    Date = as.Date(Date, format = "%d/%m/%Y"),
    Seasons = as.factor(Seasons),
    Holiday = as.factor(Holiday),
    Functioning.Day = as.factor(Functioning.Day)
  )


# ----

anyNA(bike)


# ----

ggplot(bike, aes(x = Rented.Bike.Count)) +
  geom_histogram(binwidth = 100, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione noleggi",
       x = "Conteggio",
       y = "Frequenza") +
  theme_minimal()


# ----

hist_hour<-ggplot(bike, aes(x = Hour)) +
  geom_histogram(binwidth = 3, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione ore",
       x = "Conteggio",
       y = "Frequenza") +
  theme_minimal()

hist_count_hour<-ggplot(bike, aes(x = Hour, y = Rented.Bike.Count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Noleggi per Ora",
       x = "Ora del Giorno",
       y = "Numero di Noleggi") +
  theme_minimal()

grid.arrange(hist_hour, hist_count_hour, ncol=2)


# ----

bp_season<-ggplot(bike, aes(x = Seasons)) +
  geom_bar(fill = c("brown", "orange", "yellow", "steelblue"), alpha = 0.7) +
  labs(title = "Noleggi per stagioni",
       x = "Seasons",
       y = "Count")

bp_holiday<-ggplot(bike, aes(x = Holiday)) +
  geom_bar(fill = c("steelblue", "orange"), alpha = 0.7) +
  labs(title = "Noleggi per holiday",
       x = "Holiday",
       y = "Bici Noleggiate")

grid.arrange(bp_season, bp_holiday, ncol=2)


# ----


#temp
hist_temp<-ggplot(bike, aes(x = Temperature)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione temperature",
       x = "Temperature",
       y = "Frequenza") +
  theme_minimal()


sp_temp_bike<-ggplot(bike, aes(x = Temperature, y = Rented.Bike.Count, color = Temperature)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot temperatura-noleggi",
       x = "Temperatura",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") +  # Imposta i colori di gradiente
  theme_minimal()

grid.arrange(hist_temp, sp_temp_bike, ncol=2)

#hum
hist_hum<-ggplot(bike, aes(x = Humidity)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione umidità",
       x = "Umidità",
       y = "Frequenza") +
  theme_minimal()

sp_hum_bike<-ggplot(bike, aes(x = Humidity, y = Rented.Bike.Count, color = Humidity)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot umidità-noleggi",
       x = "Umidità",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") + 
  theme_minimal()

grid.arrange(hist_hum, sp_hum_bike, ncol=2)


# ----


#wind
hist_wind<-ggplot(bike, aes(x = Wind.speed)) +
  geom_histogram(binwidth = 0.1, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione velocità vento",
       x = "Velocità del vento",
       y = "Frequenza") +
  theme_minimal()


sp_wind_bike<-ggplot(bike, aes(x = Wind.speed, y = Rented.Bike.Count, color = Wind.speed)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot vento-noleggi",
       x = "vento",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") + 
  theme_minimal()

grid.arrange(hist_wind, sp_wind_bike, ncol=2)

#visibility
hist_vis<-ggplot(bike, aes(x =Visibility)) +
  geom_histogram(binwidth = 100, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione visibilità",
       x = "visibilità",
       y = "Frequenza") +
  theme_minimal()

sp_vis_bike<-ggplot(bike, aes(x = Visibility, y = Rented.Bike.Count, color = Visibility)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot visibilità-noleggi",
       x = "visibilità",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") + 
  theme_minimal()

grid.arrange(hist_vis, sp_vis_bike, ncol=2)


# ----


#rain
hist_rain<-ggplot(bike, aes(x = Rainfall)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione pioggia",
       x = "Pioggia",
       y = "Frequenza") +
  theme_minimal()

sp_rain_bike<-ggplot(bike, aes(x = Rainfall, y = Rented.Bike.Count, color = Rainfall)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot pioggia-noleggi",
       x = "pioggia",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") + 
  theme_minimal()


grid.arrange(hist_rain, sp_rain_bike, ncol=2)

#snow
hist_snow<-ggplot(bike, aes(x =Snowfall)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuzione neve",
       x = "neve",
       y = "Frequenza") +
  theme_minimal()

sp_snow_bike<-ggplot(bike, aes(x = Snowfall, y = Rented.Bike.Count, color = Snowfall)) +
  geom_point(alpha = 0.7) +
  labs(title = "Scatterplot neve-noleggi",
       x = "neve",
       y = "Numero di noleggi") +
  scale_color_gradient(low = "steelblue", high = "orange") + 
  theme_minimal()

grid.arrange(hist_snow, sp_snow_bike, ncol=2)


# ----

numeric_data <- bike %>%
  select_if(is.numeric)

corrplot(cor(numeric_data), type = "upper", tl.srt = 45, tl.cex = 0.7, method = "number")



# ----

pairs(bike[, c("Temperature", "Dew.point.temperature", "Humidity")])


# ----

bike <- subset(bike, select = -Date) 

set.seed(1)
index<-createDataPartition(bike$Rented.Bike.Count, p=0.7)
train_set=bike[index$Resample1,]
test_set=bike[-index$Resample1,]



# ----

dim(train_set)


# ----

dim(test_set)


# ----

bike.fit.poi <- glm(Rented.Bike.Count ~ .- Functioning.Day,
                    data=train_set, 
                    family=poisson(log))

summary(bike.fit.poi)


# ----

bike.fit.poi2 <- glm(Rented.Bike.Count ~.-Dew.point.temperature-Functioning.Day,
                    data=train_set, 
                    family=poisson(log))


# ----

anova(bike.fit.poi,bike.fit.poi2, test="LRT")

BIC(bike.fit.poi,bike.fit.poi2)  
AIC(bike.fit.poi,bike.fit.poi2)


# ----

(exp(coef(bike.fit.poi))-1)*100


# ----

pred.hour<-ggpredict(bike.fit.poi, "Hour[8:16]")
me_hour<-plot(pred.hour)

pred.temp<-ggpredict(bike.fit.poi, "Temperature[-5:30]")
me_temp<-plot(pred.temp)

grid.arrange(me_hour, me_temp, ncol=2)



# ----

pred.r_h<-ggpredict(bike.fit.poi, c("Rainfall[0:5]", "Holiday"))
plot(pred.r_h)


# ----

pred.dewpoint<-ggpredict(bike.fit.poi, "Dew.point.temperature[10:20]")
plot(pred.dewpoint)


# ----


set.seed(123)
idx2<-createDataPartition(bike$Rented.Bike.Count, p=0.7)
train_nb=bike[idx2$Resample1,]
test_nb=bike[idx2$Resample1,]


# ----


bike.fit.nb <- glm.nb(Rented.Bike.Count ~ Wind.speed + Hour + Humidity + Visibility +
                        Dew.point.temperature + Snowfall + Seasons + Holiday + Solar.Radiation +
                        Functioning.Day + Temperature,
                    data = train_nb)

summary(bike.fit.nb)

bike.fit.nb2<- glm.nb(Rented.Bike.Count ~ Wind.speed + Hour + Humidity  +
                        Dew.point.temperature + Snowfall + Seasons + Holiday  +
                        Temperature,
                        data=train_nb)


# ----

anova(bike.fit.nb, bike.fit.nb2)

AIC(bike.fit.nb,bike.fit.nb2) 
BIC(bike.fit.nb,bike.fit.nb2)


# ----

(exp(coef(bike.fit.nb))-1)*100


# ----

AIC(bike.fit.poi, bike.fit.nb)
BIC(bike.fit.poi, bike.fit.nb)



# ----


new.bikers <- data.frame(
  Hour = rep(14, 4),
  Temperature = rep(20, 4),
  Humidity = rep(60, 4),
  Wind.speed = rep(2.8, 4),
  Visibility = rep(1500, 4),
  Dew.point.temperature = rep(10, 4),
  Solar.Radiation = rep(2.9, 4),
  Snowfall = rep(0, 4),
  Seasons = rep(levels(bike$Seasons)[1:4], each = 1), 
  Holiday = rep(levels(bike$Holiday)[1], 4),
  Functioning.Day = rep(levels(bike$Functioning.Day)[2], 4)
)


predict(bike.fit.nb, newdata = new.bikers, type = "response") 


# ----

new.bikers3 <- data.frame(
  Hour = rep(17, 4),
  Temperature = rep(14, 4),
  Humidity = rep(60, 4),
  Wind.speed = rep(1.5:5, each = 1.3),
  Visibility = rep(1200, 4),
  Dew.point.temperature = rep(15, 4),
  Solar.Radiation = rep(1.2, 4),
  Snowfall = rep(0, 4),
  Seasons = rep(levels(bike$Seasons)[1], 4),
  Holiday = rep(levels(bike$Holiday)[1], 4),
  Functioning.Day = rep(levels(bike$Functioning.Day)[2], 4)
)

predict(bike.fit.nb, newdata = new.bikers3, type = "response") 
