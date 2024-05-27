
library(readr)

#make sure the training data files provided are in the current directory

#read annotation data for all training samples
meta = as.data.frame(read_csv("Sample_annotation.csv"))
rownames(meta)<-meta$Sample_ID

#read feature data for the first 100 features only and all samples (for speed reasons)
#remove ,n_max =100 argument to read all features
#samples are columns and rows are features
X=as.data.frame(read_csv("Beta_raw_subchallenge1.csv",n_max =100))
rownames(X)=X[,1]
X=X[,-1] #drop the sample name column

#transpose the feature data
X=t(X)


#extract the target gestational age and merge it with feature data
dat=cbind(data.frame(X),GA=meta[rownames(X),"GA"]) 

#fit a simple linear model that predicts GA using all 100 methylation features
model=lm(GA~.,data=dat)

#save the model needed for docker submission
saveRDS(model, file="model_test_SC1.rds")