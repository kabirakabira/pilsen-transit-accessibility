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

#! Read in files
chicago.gtfs <- read_gtfs("data/raw/chicago_gtfs_10-14-2024.zip")

#! 