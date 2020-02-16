#### 0.   INCLUDES / PREPARING DATA _______________________________________ #### 

#Load Libraries: p_load can install, load,  and update packages
if(require("pacman")=="FALSE"){
  install.packages("pacman")
} 

# Load/install the other pakcages
pacman::p_load(rstudioapi,dplyr, ggplot2, lubridate, devtools, tidyr,magrittr, 
               lemis)

# Setwd (set current wd where is the script, then we move back to the 
# general folder)
current_path = getActiveDocumentContext()$path 
setwd(dirname(current_path))
setwd("..")
rm(current_path)

# Reading dataset 
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
levels(data$taxa)   # 14 levels
ggplot(data, aes(x=taxa, fill=taxa)) + geom_bar() +
  theme(axis.text.x = element_text(angle=60, hjust=1)) 
