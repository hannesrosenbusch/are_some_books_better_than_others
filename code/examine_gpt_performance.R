#test set performance
library(dplyr)

set.seed(42)
df = read.csv("fiction.csv") %>%
  filter(gpt_review_labels != "labels missing")

#avoiding examples seen by me or AI during training
random_test_set = sample(300:(nrow(df)- 100), 200)

##manual labeling
# nr_errors = c()
# NR_TOPICS = 6
# for(i in random_test_set){
#   print("")
#   print("")
#   print(df[i, "book_review_user"])
#   print(df[i, "gpt_review_labels"])
#   print("")
#   print("")
#   input = readline(prompt = "nr errors (0-6)?")
#   nr_errors = c(nr_errors, input)
# }
# outdf = data.frame(id = random_test_set, nr_errors = nr_errors)
# outdf$nr_errors[outdf$nr_errors == ""] = 0
## write.csv(outdf, "test_performance_gpt.csv")

overall_accuracy = 1 - sum(as.numeric(outdf$nr_errors)) / (nrow(outdf) * NR_TOPICS)
alpha_post <- 1 + (nrow(outdf) * NR_TOPICS) - sum(as.numeric(outdf$nr_errors))
beta_post <- 1 + sum(as.numeric(outdf$nr_errors))
credible_interval <- qbeta(c(0.025, 0.975), alpha_post, beta_post)                        
