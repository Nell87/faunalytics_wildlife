#### 0.   INCLUDES / PREPARING DATA _______________________________________ #### 

#Load Libraries: p_load can install, load,  and update packages
if(require("pacman")=="FALSE"){
  install.packages("pacman")
} 

# Install fstplyr package
# remotes::install_github("krlmlr/fstplyr")

# Install the stringi package
# install.packages("stringi", dependencies=TRUE, INSTALL_opts = c('--no-lock'))

# Load/install the other pakcages
pacman::p_load(rstudioapi,dplyr, ggplot2, lubridate, devtools, rlang, stringi,
               tidyr,magrittr)

# Setwd (set current wd where is the script, then we move back to the 
# general folder)
current_path = getActiveDocumentContext()$path 
setwd(dirname(current_path))
setwd("..")
rm(current_path)

# Create a GitHub PAT
# usethis::browse_github_pat()

# Put your PAT in your .Renviron file. You can edit your .Renviron file with 
# this function 
# usethis::edit_r_environ()

# Check that the PAT is available 
usethis::git_sitrep()

# Install Rtools from http://cran.r-project.org/bin/windows/Rtools/

# Install the lemis package (download Github repo)
# The lemis R package provides access to the United States Fish and Wildlife 
# Service's (USFWS) Law Enforcement Management Information System (LEMIS) data 
# on wildlife and wildlife product imports into the US.
# devtools::install_github("ecohealthalliance/lemis")

# Loading lemis package
pacman::p_load(lemis)

# Reading dataset
# data<- lemis_data()
# saveRDS(data, file="./data/data.rds")
data<-readRDS("./data/data.rds")

#### 1.   CLEANING / PREPROCESSING ####
#### 1.1. Transformations _________________________________________________ ####
# Dimensions
dim(data)          # <-  5.512.706 rows    28 columns

# Transform some variables to factor/numeric/datetime
data %<>% mutate_at(c("control_number", "species_code", "taxa", "class", "genus",
                      "species", "subspecies", "specific_name", "generic_name",
                      "description", "country_origin", "country_imp_exp", 
                      "purpose","source", "action", "disposition", 
                      "disposition_year", "shipment_year", "import_export",
                      "port", "us_co", "foreign_co", "unit"), as.factor)

data$disposition_date<- lubridate::ymd(data$disposition_date)
data$shipment_date<- lubridate::ymd(data$shipment_date)

# Checking data types
data_types<- data %>% 
  dplyr::summarise_all(class) %>% 
  tidyr::gather(variable, class)

rm(data_types)

#### 2.0  EXPLORATORY ANALYSIS #### 

#### 2.1. TAXA  ___________________________________________________________ ####


