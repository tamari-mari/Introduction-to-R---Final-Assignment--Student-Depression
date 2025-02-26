### SCRIPT 3 - Data Analysis ###

#Cleaning the workspace
rm(list = ls())

#Uploading previous file
source("final assignment 1 - data exploration.R")
source("final assignment 2 - pre-processing.R")


### LINEAR REGRESSION ###

#The effect of depression on financial stress
model1 <- lm(df$Financial.Stress ~ Depression_factor + Academic.Pressure, data = df)
summary(model1)

#The effect of depression on academic pressure
lm_model2 <- lm(Academic.Pressure ~ Depression_factor + Financial.Stress, data = df)
summary(lm_model2)


### LOGISTIC REGRESSION ###

#The effect of academic pressure and financial stress on depression
model4 <- glm(Depression_factor ~ Financial.Stress + Academic.Pressure + Stress_Interaction, data = df, family = "binomial")
summary(model4)
exp(coef(model4))


### GRAPHS ###

#Depression and financial stress

ggplot(df, aes(x = Depression_factor, y = Financial.Stress, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Effect of Depression on Financial Stress",
       x = "Depression",
       y = "Financial Stress") +
  scale_fill_manual(values = c("skyblue3", "coral2"))

#Depression and academic pressure

ggplot(df, aes(x = Depression_factor, y = Academic.Pressure, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Effect of Depression on Academic Pressure",
       x = "Depression",
       y = "Academic Pressure") +
  scale_fill_manual(values = c("aquamarine3", "violet"))

#Depression, financial stress and academic pressure

ggplot(df, aes(x = Financial.Stress, y = as.numeric(Depression_factor) - 1, color = Academic.Pressure)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = TRUE) +
  theme_minimal() +
  labs(title = "Effect of Financial Stress & Academic Pressure on Depression",
       x = "Financial Stress",
       y = "Probability of Depression",
       color = "Academic Pressure") +
  scale_color_gradient(low = "deepskyblue", high = "magenta3")

ggplot(df, aes(x = Academic.Pressure, y = as.numeric(Depression_factor) - 1, color = Financial.Stress)) +
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = TRUE) +
  theme_minimal() +
  labs(title = "Effect of Academic Pressure & Financial Stress on Depression",
       x = "Academic Pressure",
       y = "Probability of Depression",
       color = "Financial Stress") +
  scale_color_gradient(low = "deepskyblue", high = "magenta3")


### ROC CURVE ###

#Predicted probabilities
df_clean <- na.omit(df)  
df_clean$predicted_prob <- predict(model4, newdata = df_clean, type = "response")

#ROC curve
roc_curve <- roc(df_clean$Depression_factor, df_clean$predicted_prob)

#AUC
auc_value <- auc(roc_curve)
print(paste("AUC:", round(auc_value, 3)))

#Plot ROC curve
ggplot(data.frame(TPR = roc_curve$sensitivities, FPR = 1 - roc_curve$specificities), aes(x = FPR, y = TPR)) +
  geom_line(color = "mediumpurple3", size = 1) +
  geom_abline(linetype = "dashed", color = "mediumpurple1") +  
  theme_minimal() +
  labs(title = paste("ROC Curve (AUC =", round(auc_value, 3), ")"),
       x = "False Positive Rate (1 - Specificity)",
       y = "True Positive Rate (Sensitivity)")
