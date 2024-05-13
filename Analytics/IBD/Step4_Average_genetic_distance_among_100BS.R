## NOTE1: R script to average 100 bootstrap replicates of genetic distance matrices
## NOTE2: Requires the output of Step 3 as an input (see Step4_outI.dist as an example).

all.data = c("outI")
setwd("IBD/")
sink(file = "mean100.log", append = T)
for(myname in all.data){
  print(myname)
  data = read.table(paste0(myname, ".dist"), fill=T)
  n_sample = as.numeric(data[1,1])
  n_boost = nrow(data)/(n_sample+1)
  print(paste0("#samples = ", n_sample))
  print(paste0("#boost replicates = ", n_boost))
  #"if more than 100 boosts, use only the first 100 boost replicates; otherwise use all"
  if(n_boost > 100){
    data = data[1:((n_sample+1)*100),]
  }
  samples = data[2:(n_sample+1),1]
  colnames(data) = c("sample", samples)
  myout = matrix(nrow=n_sample, ncol=n_sample, dimnames=list(samples, samples))
  for(i in 1:n_sample){
    for(j in i:n_sample){
      myout[j, i] = mean(data[data$sample == samples[i], samples[j]])
    }
  }
  write.table(myout, paste0("outputs/", myname, "_mean100_corrected.csv"), sep=";", quote = F, na="")
  print("\n")
}
sink()

