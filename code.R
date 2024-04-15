library(tidyverse)
library(gridExtra)
library(car)
library(caret)
library(pROC)
library(randomForest)

# 读取数据
df <- read.csv("data.csv") 

# 数据可视化
bar_plot_list <- lapply(names(df), function(var) {
  ggplot(df, aes(x = df[[var]])) +
    geom_bar() +
    labs(title = paste("Bar Plot of", var),
         x = var,
         y = "Frequency")
})
grid.arrange(grobs = bar_plot_list, ncol = 4)

bar_plot_list_2 <- lapply(names(df), function(var) {
  ggplot(df, mapping = aes(x = df[[var]])) +
    geom_bar() + 
    facet_wrap( ~ Approved) +
    labs(title = paste("Bar Plot of", var),
         x = var,
         y = "Frequency")
})
grid.arrange(grobs = bar_plot_list_2, ncol = 4)

par(mfrow=c(1,5))
boxplot(Age ~ Approved, data = df, outline = FALSE)
boxplot(Debt ~ Approved, data = df, outline = FALSE)
boxplot(YearsEmployed ~ Approved, data = df, outline = FALSE)
boxplot(CreditScore ~ Approved, data = df, outline = FALSE)
boxplot(Income ~ Approved, data = df, outline = FALSE)


# 逻辑回归
lm_model <- glm(Approved ~ Gender + Age + Debt + Married +
                  BankCustomer + Industry + Ethnicity + YearsEmployed +
                  PriorDefault + Employed + CreditScore + DriversLicense +
                  Citizen + ZipCode + Income, data = df, family = "binomial")
summary(lm_model)
vif(lm_model)

step_model <- step(lm_model, direction = "both")
summary(step_model)

set.seed(123)
index <- createDataPartition(df$Approved, p = 0.8, list = FALSE)
train_data <- df[index, ]
test_data <- df[-index, ]

model <- glm(Approved ~ Ethnicity + PriorDefault + Employed + 
             CreditScore + Citizen + ZipCode + Income, 
             family = "binomial", data = train_data)
summary(model)

predictions <- predict(model, newdata = test_data, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)


# 随机森林
rf_model <- randomForest(Approved ~ ., data = train_data, mtry = sqrt(ncol(df)-1))
par(mfrow=c(1,2))
plot(rf_model)
varImpPlot(rf_model)
variable_importance <- importance(rf_model)
sorted_importance <- variable_importance[order(variable_importance[, 1], decreasing = TRUE), ]
print(sorted_importance)

rf_predictions <- predict(rf_model, newdata = test_data, type = "response")
rf_predicted_classes <- ifelse(rf_predictions > 0.5, 1, 0)

# 模型比较
par(mfrow=c(1,1))
# 逻辑回归
conf_matrix <- table(predicted_classes, test_data$Approved)
print(conf_matrix)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", accuracy))

roc_curve <- roc(test_data$Approved, predictions)
auc_value <- auc(roc_curve)
print(paste("AUC for Logistic Regression:", auc_value))
plot(roc_curve, col = "blue", main = "ROC Curve", col.main = "black", lwd = 2)

# 随机森林
rf_conf_matrix <- table(rf_predicted_classes, test_data$Approved)
print(rf_conf_matrix)
rf_accuracy <- sum(diag(rf_conf_matrix)) / sum(rf_conf_matrix)
print(paste("Random Forest Accuracy:", rf_accuracy))

roc_curve_rf <- roc(test_data$Approved, rf_predictions)
auc_value_rf <- auc(roc_curve_rf)
print(paste("AUC for Random Forest:", auc_value_rf))
plot(roc_curve_rf, col = "red", add = TRUE)

legend("bottomright", legend = c("Logistic Regression", "Random Forest"), col = c("blue", "red"), lwd = 2)
