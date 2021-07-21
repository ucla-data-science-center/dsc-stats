# install.packages("devtools")
#devtools::install_github("tidyverse/googlesheets4")
library(janitor)
library(readr)
library(lubridate)

### Workshop stats 

## stats from 2017-2019 
workshop_obs <- read_csv('data/dsc-workshop-attendance-2017-2019.csv')
save(workshop_obs, file="data/workshop_obs.RData")
load('data/workshop_obs.RData')

dsc_2017_2019_workshops <- workshop_obs %>% 
  select(event, date, role, dept, tool, division) %>% 
  rename(department = dept, categories = tool, status = role)

## read in stats from 2020 on (including gis week)
uc_gis2020 <- read_tsv('data/uc-gis-week-2020.tsv')
dsc_2020_libcal <- read_tsv('data/2020-libcal-events_cleaned-tsv.tsv')
dsc_uc_2020_events <- full_join(uc_gis2020, dsc_2020_libcal) 

# merge older data with 2020
dsc_2017_20_events <- full_join(dsc_uc_2020_events, dsc_2017_2019_workshops)

# read in 2021 events data
dsc_2021_events <- read_tsv("data/dsc_2021_events.tsv")

#2017-2021 data merged
dsc_2017_21_workshops <- full_join(dsc_2017_20_events, dsc_2021_events)
load('data/dsc_events_all.RData')
dsc_2017_21_workshops <- dsc_2017_21_workshops %>% 
  mutate(department = replace(department, department == "Graduate School of Education and Information Studies", "Information Studies")) %>% 
  mutate(department = replace(department, department == "Urban Planning", "Urban & Regional Planning")) %>% 
  mutate(department = replace(department, department == "Institute of the Environment & Sustainability", "IoES")) %>% 
  mutate(department = replace(department, department == "UCLA Library", "Library")) %>% 
  mutate(status = replace(status, status == "Graduate", "Graduate Student")) %>% 
  mutate(status = replace(status, status == "Graduate/Postdoc", "Graduate Student")) %>% 
  mutate(status = replace(status, status == "Undergrad", "Undergraduate Student")) %>% 
  mutate(status = replace(status, status == "Undergraduate", "Undergraduate Student")) %>% 
  mutate(status = replace(status, status == "Researcher", "Faculty")) %>% 
  mutate(status = replace(status, status == "PostDoc", "Postdoc")) %>% 
  mutate(status = replace(status, status == "Alumnus", "Alumni")) %>% 
  mutate(status = replace(status, status == "Graduate, Staff", "Graduate Student")) 

write_csv(dsc_2017_21_workshops, 'data/dsc_2017_21_workshops.csv')

save(dsc_2017_21_workshops, file='data/dsc_events_all.RData')

#save out as rda
save(workshop_obs, file="data/workshop_obs.RData")

## consulting 

consulting_obs <- read_csv('data/calendly-events-export-2017-2019.csv')

consulting_obs <- clean_names(consulting_obs)

#cleaning up and dropping uneeded columns

consulting_obs <- consulting_obs %>% 
  mutate(start_date_time = mdy_hm(start_date_time)) %>% 
  select(start_date_time, response_1)

save(consulting_obs, file="data/consulting_obs.RData")
