library(tidyverse)
library(lubridate)
library(janitor)
library(ggplot2)
library(calecopal)

## workshops

dsc17_21_wkshps <- read_csv("data/dsc_2017_21_workshops.csv")

dsc17_21_wkshps_wk <- dsc17_21_wkshps %>% 
  count(year=year(date), week=week(date), sort = TRUE, name="attendance") %>% 
  mutate(week_date = as.Date(paste(week, year, 'Mon'), '%U %Y %a')) %>% 
  #filter(week >= 32 & week <= 42) %>% 
  arrange(year, week)

dsc_2017_21_workshops %>% 
  count(year(date))

write_csv(dsc17_21_wkshps_wk, "dsc17_21_workshopsbyweek.csv")

#as.Date(paste(dsc17_21_wkshps_wk$week, dsc17_21_wkshps_wk$year, 'Sun'), '%U %Y %a')

## Consults

dsc17_21_consults <- read.csv("data/consults-events-export-8.csv")

## clean names 
dsc17_21_consults <- clean_names(dsc17_21_consults)

dsc17_21_consults$date <- ymd(dsc17_21_consults$date)

## raw data with consultant 
dsc17_21_consults %>% 
  select(consultant, date) %>% 
  write_csv("data/dsc17_21_with_consultant.csv")


## aggregated by week 
dsc17_21_consults_wk <- dsc17_21_consults %>% 
  count(year=year(date), week=week(date), sort = TRUE, name="dsc_consults") %>% 
  mutate(week_date = as.Date(paste(week, year, 'Mon'), '%U %Y %a')) %>% 
  #filter(week >= 32 & week <= 42) %>% 
  arrange(year, week)

write_csv(dsc17_21_consults_wk, "data/dsc17_21_consultsbyweek.csv")

dsc17_21_consults_wk %>% 
  ggplot(aes(reorder(year, -dsc_consults), dsc_consults)) + geom_col(fill = "#2774AE") + 
  coord_flip() + 
  scale_fill_manual(values=cal_palette("kelp1")) +
  labs(x= "Year", y="Consults") +
  theme(axis.text.x = element_text(angle = 45, size = 10, hjust = 1))  +
  #geom_text(aes(label=dsc_consults), hjust= -0.12) +
  theme_minimal()
  
