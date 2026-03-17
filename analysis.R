library(data.table) #To deal with big datasets. overkill maybe
library(chisq.posthoc.test)

set.seed(12345)

## loading files

path <- 'data.csv'


#### OPEN DATA ####

full_data <- fread(path)
head(full_data)

# Renaming variables for ease of read
full_data$antlion_angular_half_start<-full_data$antlion_angular_pos_start
full_data$antlion_angular_half_start <- as.character(full_data$antlion_angular_half_start)
full_data$antlion_angular_half_start[full_data$antlion_angular_pos_start > 0] <- 'positive'
full_data$antlion_angular_half_start[full_data$antlion_angular_pos_start < 0] <- 'negative'
full_data$antlion_angular_half_start[full_data$antlion_angular_pos_start == 0] <- 'optimal'
full_data$antlion_angular_half_start[full_data$antlion_angular_pos_start==180] <- 'reversed'

# Renaming variables for ease of read
full_data$antlion_angular_pos_start <- as.factor(full_data$antlion_angular_pos_start)
full_data$antlion_angular_half_start <- as.factor(full_data$antlion_angular_half_start)
full_data$rotated_direction[full_data$rotated_direction == 'CW'] <- 'clockwise'
full_data$rotated_direction[full_data$rotated_direction == 'CCW'] <- 'counter-clockwise'
full_data$rotated_direction[full_data$rotated_direction == ''] <- 'no rotation'
full_data$rotated_direction <- as.factor(full_data$rotated_direction)

# Analysis
tabled <- table(full_data$antlion_angular_half_start, full_data$rotated_direction)
chisq.test(tabled)
posthoc_results <- chisq.posthoc.test(tabled, method = "bonferroni")
print(posthoc_results)
