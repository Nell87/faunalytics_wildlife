#Load Libraries: p_load can install, load,  and update packages
if(require("pacman")=="FALSE"){
  install.packages("pacman")
} 

# Load/install the other pakcages
pacman::p_load(rstudioapi,devtools)

# Setwd (set current wd where is the script, then we move back to the 
# general folder)
current_path = getActiveDocumentContext()$path 
setwd(dirname(current_path))
setwd("..")
rm(current_path)

# Install some packages 
install.packages("digest", dependencies=TRUE)
devtools::install_github("ropenscilabs/datastorr")

# Install the lemis package (download Github repo)
# The lemis R package provides access to the United States Fish and Wildlife 
# Service's (USFWS) Law Enforcement Management Information System (LEMIS) data 
# on wildlife and wildlife product imports into the US.
devtools::install_github("ecohealthalliance/lemis")

# Reading dataset  - You will need to download the dataset the first time - 
library(lemis)
data<- lemis_data()   
dir.create("./data")
saveRDS(data, file="./data/data.rds")

