sinkall <- function() {
  i <- sink.number()
  while (i > 0) {
    sink()
    i <- i - 1
  }
}

create_confusion_matrix <-
  function(
    forest_predictions,
    actual,
    num_tree,
    level_names) {
  pred <- factor(unlist(forest_predictions))
  levels(pred) <- level_names
  levels(actual)
  file_path  <- str_c('confusion_matrices/random_forest_confusion_matrix_num_tree_',
                      num_tree,
                      '.txt')
  sink(file_path)
  print(confusionMatrix(pred, actual))
  sinkall()
}
