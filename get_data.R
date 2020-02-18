# install.packages("devtools")
#devtools::install_github("tidyverse/googlesheets4")
library(googledrive)
library(googlesheets4)
library(readr)
library(lubridate)

#getting from gdrive 
#attendance <- drive_get("attendance_lists")

# sheets_get(attendance)
# sheets_sheet_names(attendance)
# read_sheet(dsc-workshop-attendance)

# workshop_obs <- attendance %>% 
#   read_sheet("dsc-workshop-attendance")

workshop_obs <- read_csv('data/dsc-workshop-attendance-2017-2019.csv')
#workshop_obs_raw <- read_tsv('data/dsc-workshop-attendance.tsv')
#save out as rda
save(workshop_obs, file="data/workshop_obs.RData")

consulting_obs <- read_csv('data/calendly-events-export-2017-2019.csv')

consulting_obs <- clean_names(consulting_obs)

#cleaning up and dropping uneeded columns

consulting_obs <- consulting_obs %>% 
  mutate(start_date_time = mdy_hm(start_date_time)) %>% 
  select(start_date_time, response_1)

save(consulting_obs, file="data/consulting_obs.RData")
