#! Setting up workspace
## Modifying options
options(scipen = 999)
options(timeout = 999)
## Installing and loading required packages
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}
usePackage("dplyr")
usePackage("sf")
usePackage("gtfsrouter")
usePackage("tidytransit")
usePackage("tigris")

#! Step 1: Read in Chicago GTFS from Mobility Database, convert to SF
## Download GTFS feed if not already downloaded
if (!file.exists("data/raw/chicago_gtfs_10_16_24.zip")) {
download.file("https://files.mobilitydatabase.org/mdb-389/mdb-389-202410170023/mdb-389-202410170023.zip",
              "data/raw/chicago_gtfs_10_16_24.zip",
              quiet = TRUE)
}
## Read in and convert to SF
chicago.gtfs <- read_gtfs("data/raw/chicago_gtfs_10_16_24.zip")
chicago.gtfs <- gtfs_as_sf(chicago.gtfs, skip_shapes = FALSE, crs = 4326, quiet = TRUE)

#! Download Cook County block groups and calculate centroids
cook.blockgroups <- tigris::block_groups(
  state = "IL",
  county = "Cook County",
  year = 2023
) %>%
  st_centroid() %>%
  st_transform(st_crs(4326)) %>%
  select(GEOID)



