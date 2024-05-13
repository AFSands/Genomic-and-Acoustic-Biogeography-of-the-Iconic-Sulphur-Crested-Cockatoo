library(devtools)
install_github("dipetkov/eems/plotting/rEEMSplots")
install.packages(c("Rcpp","RcppEigen","raster","rgeos","sp"))
install_github("dipetkov/eems/plotting/rEEMSplots")
setwd("C:<path_to_directory>")

install.packages("rEEMSplots", repos=NULL, type="source")

library("rEEMSplots")
extdata_path  <- system.file("extdata", package = "rEEMSplots")
eems_results <- file.path(extdata_path, "EEMS-example")




eems_results <- "C:<path_to_results>"
name_figures <- "C:<path_to_outputs>"

eems.plots(
  mcmcpath = eems_results,
  plotpath = name_figures,
  longlat = TRUE,
  out.png = F
)




dev.off()

eems.plots(
  mcmcpath = eems_results,
  plotpath = paste0(name_figures, "-output-PDFs"),
  longlat = TRUE,
  plot.height = 8,
  plot.width = 7,
  res = 600,
  out.png = FALSE
)

plot(x=1, y=1)
