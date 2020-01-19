library(readr)
library(dplyr)

#read in latest libcal data as csv
stats <- read_csv("lc_events_20191225041628.csv")

#use janitor clean_names to rename variables 
stats <- clean_names(stats)

#select columns we want to retain
stats <- stats %>% 
  select(event_id, title, date, presenter, audiences, waiting_list_registrations, actual_attendance, confirmed_attendance, categories, status_graduate_student_faculty_post_doc, department_or_program)

#write out data so we can use OpenRefine to future clean up
write_csv(stats, "csv_stats_for_clean.csv")

#consider making this a python script instead to automate some openrefine elements
