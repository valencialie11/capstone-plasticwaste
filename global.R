library(shiny)
library(shinydashboard)
library(plotly)
library(tidyverse)
library(ggrepel)
library(lubridate)
library(DT)
library(leaflet)
library(readxl)

plasticprodx <- read_csv( "global-plastics-production.csv")

plasticprod %>% 
  is.na() %>% 
  colSums()

str(plasticprod)

plasticprod

inadequately_managed <- read_csv("inadequately-managed-plastic.csv")

inadequately_managed %>% 
  is.na() %>% 
  colSums()

str(inadequately_managed)
plasticprod$Year <- as.numeric(plasticprod$Year)

plasticprod_new <- plasticprod %>% 
  group_by(Year) %>% 
  summarise(sum_ton = sum(`Global plastics production`))

median(plasticprod_new$sum_ton)
min(plasticprod_new$sum_ton)
max(plasticprod_new$sum_ton)

inadequately_managed

inadequately_managed$remain <- 100-inadequately_managed$`Share of plastic inadequately managed (%)`

inadequately_managed <- inadequately_managed %>% 
  mutate(share = inadequately_managed$'Share of plastic inadequately managed (%)')

inadeq <- inadequately_managed %>% 
  pivot_longer(cols = c(share, remain), names_to = "names", values_to = "value")

inadequately_managed
inadequately_managed[order(inadequately_managed$remain),]

gdpmis <- read_csv(file="per-capita-mismanaged-plastic-waste-vs-gdp-per-capita.csv")
gdpplas <-  read_csv(file ="per-capita-plastic-waste-vs-gdp-per-capita.csv")

gdpmis

gdpmis <- gdpmis %>% 
  select(-Code)

gdp2010 <- gdpmis %>% 
  filter(Year == 2010)

gdp2010 %>% 
  is.na() %>% 
  colSums

gdp2010new <- gdp2010 %>% 
  mutate(`Mismanaged plastic waste per capita (kilograms per person per day)` = replace_na(`Mismanaged plastic waste per capita (kilograms per person per day)`, replace = mean(`Mismanaged plastic waste per capita (kilograms per person per day)`, na.rm = T)))

gdpnew <- gdp2010new %>% 
  mutate(`GDP per capita (int.-$) (international-$)` = replace_na(`GDP per capita (int.-$) (international-$)`, replace = mean(`GDP per capita (int.-$) (international-$)`, na.rm = T)))

gdp_new <- gdpnew %>% 
  mutate(Population = replace_na(Population, replace = mean(Population, na.rm = T)))

gdpplas <- gdpplas %>% 
  filter(Year == 2010)

gdp1 <- gdpplas %>% 
  mutate(`Per capita plastic waste (kilograms per person per day)` = replace_na(`Per capita plastic waste (kilograms per person per day)`, replace = mean(`Per capita plastic waste (kilograms per person per day)`, na.rm = T)))

gdp2 <- gdp1 %>% 
  mutate(`GDP per capita, PPP (constant 2011 international $) (constant 2011 international $)` = replace_na(`GDP per capita, PPP (constant 2011 international $) (constant 2011 international $)`, replace = mean(`GDP per capita, PPP (constant 2011 international $) (constant 2011 international $)`, na.rm = T)))

gdpplas1 <- gdp2 %>% 
  mutate(`Total population (Gapminder)` = replace_na(`Total population (Gapminder)`, replace = mean(`Total population (Gapminder)`, na.rm = T)))

gdpplas1 <- gdpplas1 %>% 
  select(-Code)

gdpplas2 <- gdpplas1 %>% 
  mutate(GDP = gdpplas1$`GDP per capita, PPP (constant 2011 international $) (constant 2011 international $)`)

gdpplas3 <- gdpplas2 %>% 
  mutate(plastic = gdpplas2$`Per capita plastic waste (kilograms per person per day)`)

gdp_newnew <- gdp_new %>% 
  mutate(Mismanaged = gdp_new$`Mismanaged plastic waste per capita (kilograms per person per day)`)

gdp_newnewnew <- gdp_newnew %>% 
  mutate(GDP = gdp_newnew$`GDP per capita (int.-$) (international-$)`)

fate <- read_csv(file = "global-plastic-fate.csv")

fate %>% 
  is.na() %>% 
  colSums()

fatenew <- fate %>% 
  select(-Code)

max(fatenew$Year)
fatenews <- fatenew %>% 
  group_by(Year, Entity) %>% 
  summarise (sum_values = sum(`Estimated historic plastic fate (%)`))

fateD <- fatenews %>% 
  filter(Entity == "Discarded")

fateD

fateI <- fatenews %>% 
  filter(Entity == "Incinerated")

fateR <- fatenews %>% 
  filter(Entity == "Recycled")

fateR

macromicro <- read_csv(file = "macromicroplastics-in-ocean.csv")

macromicro <- macromicro %>% 
  select(-Code)
macromicro

surface <- read_csv(file = "surface-plastic-mass-by-ocean.csv")

surfacenew <- surface %>% 
  mutate(latitude = case_when(surface$Entity == "Indian Ocean" ~ -33.137551,
                              surface$Entity == "Mediterranean Sea" ~ 34.5531284,
                              surface$Entity == "North Atlantic" ~ 35.746512,
                              surface$Entity == "North Pacific" ~ 32.694866,
                              surface$Entity == "South Atlantic" ~ 33.72434,
                              surface$Entity == "South Pacific" ~ -37.579413))

surfacenewnew <- surfacenew %>% 
  mutate(longtitude = case_when(surfacenew$Entity == "Indian Ocean" ~ 81.826172,
                              surfacenew$Entity == "Mediterranean Sea" ~ 18.048010500000032,
                              surfacenew$Entity == "North Atlantic" ~ -39.462891,
                              surfacenew$Entity == "North Pacific" ~ 162.070312,
                              surfacenew$Entity == "South Atlantic" ~ -15.996094,
                              surfacenew$Entity == "South Pacific" ~ -139.394531))

surfacenewnew

surfacenewest <- surfacenewnew %>% 
  select(-Code)

surfacenewnewnew <- surfacenewest[-1,]

surfacenewnewnew$latitude <- as.numeric(surfacenewnewnew$latitude)

surfacenewnewnew$longtitude <- as.numeric(surfacenewnewnew$longtitude)
surf <- surfacenewest[1,]

surfacenewest
raw <- read_excel("Raw data.xlsx")

rawcontrol <- raw %>% 
  filter(tank == 1, time == 4, col == "A")

rawplas <- raw %>% 
  filter(tank == 2, time == 4, col == "A")

cont1 <- rawcontrol %>% 
  group_by(genus, species) %>% 
  summarise(mean_surf = mean(surf))

cont2 <- rawcontrol %>% 
  group_by(genus, species) %>% 
  summarise(mean_weight = mean(weight))

cont3 <- rawcontrol %>% 
  group_by(genus, species) %>% 
  summarise(mean_vol = mean(vol))

cont22 <- cont2 %>% 
  select(mean_weight)
cont33 <- cont3 %>% 
  select(mean_vol)

contt <- cbind(cont1, cont22, cont33)

contnew <- contt %>% 
select(-genus1, -genus2)

plast1 <- rawplas %>% 
  group_by(genus, species) %>% 
  summarise(mean_surf = mean(surf))

plast2 <- rawplas %>% 
  group_by(genus, species) %>% 
  summarise(mean_weight = mean(weight))

plast3 <- rawplas %>% 
  group_by(genus, species) %>% 
  summarise(mean_vol = mean(vol))

plastt <- cbind(plast1, plast2, plast3)

plastnew <- plastt %>% 
  select(-genus1, -species1, -genus2, -species2)

plastnew <- plastnew %>% 
  mutate(envi = "plastic")

contnew <- contnew %>% 
  mutate(envi = "controlled")

new <- rbind(contnew, plastnew)

newsurf <- new %>% 
  select(genus, envi, mean_surf)

newweight <- new %>% 
  select(genus, envi, mean_weight)

newvol <- new %>% 
  select(genus, envi, mean_vol)

newsurf

