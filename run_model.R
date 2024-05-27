library(readr)
library(optparse)




option_list <- list(
  make_option("--input", type="character", default="/input",
              help="Input directory [default=/input]", metavar="character"),
  make_option("--output", type="character", default="/output", 
              help="Output directory [default=/output]", metavar="character")
) 

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

test_data = as.data.frame(read_csv(file.path(opt$input, "Leaderboard_beta_subchallenge1.csv"))) 
rownames(test_data)=test_data[,1]
test_data=test_data[,-1] #d

Sample_IDs<-colnames(test_data)

model = readRDS("/usr/local/bin/model_test_SC1.rds")


test_data<- as.data.frame(t(test_data))


#make predictions
ga = predict(model,test_data)
#make sure predictions are not outside the valid range
ga[ga>44]<-44
ga[ga<5]<-5

#prepare output
output_df = data.frame(
  Sample=Sample_IDs,
  GA_prediction = ga)

names(output_df)<-c("ID","GA_prediction")
write_csv(output_df,  file.path(opt$output, "predictions.csv"))
