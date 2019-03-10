myeloma_data <- read.table("start_data/GDS531_after_anova.csv",
                            sep = ",",
                            header = TRUE)
rand_seed <- 1030
set.seed(rand_seed)
nr <- nrow(myeloma_data)
max_tree <- 30
for (j in 11:max_tree) {
  random_forest_predictions <- list()
  for (i in  1:nr) {
    train <- myeloma_data[-c(i), ]
    test <- myeloma_data[i,]
    rf.fit <- ranger(state ~ ., data = train, num.trees = j, seed = rand_seed)
    pred <- predict(rf.fit, test)
    random_forest_predictions[[i]] <- pred$predictions
  }

  pred_df <- data.frame(unlist(random_forest_predictions))
  names(pred_df) <- "predictions"
  # back up the result since this took awhile to run
  file_path  <- str_c('intermediate_data/LOOCV_random_forest_results_num_tree_',
                      j, '.csv')
  write.csv(pred_df,
             file = file_path,
             row.names = FALSE)
}
