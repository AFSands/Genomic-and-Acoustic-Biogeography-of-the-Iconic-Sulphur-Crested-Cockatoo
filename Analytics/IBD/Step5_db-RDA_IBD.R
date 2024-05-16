## NOTE1: R script for running db-RDA IBD
## NOTE2: This script uses a slighty reformated genetic distance maxtrix from Step4 (modified in excel to semicolon seperated; see Step5_outI_mean100_corrected.csv - herein termed "outI_mean100_corrected.csv")
## NOTE3: This script uses a list of GPS coordinate data for the specimens incoporated (see Step5_I_coords.csv - herein termed "I_coords.csv")
## NOTE4: This script uses a slighty reformated geographic distance maxtrix (in km) from GeographicDistanceMatrixGenerator_v1.2.3 (modified in excel to semicolon seperated; see Step5_I_GGD.csv - herein termed "I_GGD.csv")
#########################################################################

setwd("C:<path_to_files>")
install.packages("vegan")
library(vegan)

# import genetic distance matrix
I_dist_GD <- read.csv("outI_mean100_corrected.csv", row.names = 1, sep = ";")

# import geographic coordinates and geographic distance matrices
I_coords <- read.csv("I_coords.csv", row.names = 1, sep = ";")
I_GGD <- read.csv("I_GGD.csv", row.names = 1, sep = ";")

# run PCoA of pairwise geographic distances, select first principal coordinate as input below
I_GGD_pcoa <- cmdscale(as.dist(I_GGD), eig=T)
I_coords["GGD"] <- I_GGD_pcoa$points[,1]

# test for correlation among latitude, longitude and geographic distance
cor(I_coords)

# I db-RDA for dist
I_dist_GD_rda <- capscale(as.dist(I_dist_GD) ~ GGD, I_coords, add = T)
summary(I_dist_GD_rda)
plot(I_dist_GD_rda)
anova.cca(I_dist_GD_rda, permutations = 9999)
RsquareAdj(I_dist_GD_rda)
