uc_gis2020 <- read_tsv('data/uc-gis-week-2020.tsv')
dsc_2020_libcal <- read_tsv('data/2020-libcal-events_cleaned-tsv.tsv')

rbind(uc_gis2020, dsc_2020_libcal)
dsc_uc_2020_events <- full_join(uc_gis2020, dsc_2020_libcal) 
names(dsc_uc_2020_events)
names(workshop_obs)
