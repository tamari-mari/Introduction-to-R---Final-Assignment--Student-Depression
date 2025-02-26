### SCRIPT 2 - Pre-Processing ###

#Cleaning the workspace
rm(list = ls())

#Uploading previous file
source("final assignment 1 - data exploration.R")


### DEFINING VARIABLES ###

df <- df %>%
  mutate(
    Depression_factor = factor(Depression, levels = c(0,1), labels = c("0", "1")),
    Academic.Pressure = as.numeric(as.character(df$Academic.Pressure)),
    Financial.Stress = as.numeric(as.character(df$Financial.Stress))
  )

glimpse(df)

### PROCESSING VARIABLES ###

#Interaction variable

df <- df %>%
  mutate(
    Stress_Interaction = Financial.Stress * Academic.Pressure 
  )

#Outliers

df <- df %>%
  mutate(
    Financial_Stress_Outlier = ifelse(Financial.Stress > (mean(Financial.Stress, na.rm = TRUE) + 2*sd(Financial.Stress, na.rm = TRUE)), "High Outlier", "Normal"),
    Academic_Pressure_Outlier = ifelse(Academic.Pressure > (mean(Academic.Pressure, na.rm = TRUE) + 2*sd(Academic.Pressure, na.rm = TRUE)), "High Outlier", "Normal")
  )

df <- df %>%
  filter(Financial_Stress_Outlier == "Normal", Academic_Pressure_Outlier == "Normal")

#Descriptive statistics
df %>%
  group_by(Depression) %>%
  summarize(
    Avg_Financial_Stress = mean(Financial.Stress, na.rm = TRUE),
    Avg_Academic_Pressure = mean(Academic.Pressure, na.rm = TRUE),
    Count = n()
  )

df %>%
  group_by(Age) %>%
  summarize(
    Avg_Financial_Stress = mean(Financial.Stress, na.rm = TRUE),
    Avg_Academic_Stress = mean(Academic.Pressure, na.rm = TRUE),
    Depression_Rate = mean(as.numeric(Depression_factor) - 1, na.rm = TRUE)
  )

#Correlations
df %>%
  select(Financial.Stress, Academic.Pressure) %>%
  cor(use = "complete.obs")

df %>%
  select(Financial.Stress, Depression) %>%
  cor(use = "complete.obs")

df %>%
  select(Academic.Pressure, Depression) %>%
  cor(use = "complete.obs")


### ORIGINAL FUNCTION ###

#Data quality
summarize_data <- function(df) {
  
  #Missing values
  missing_values <- df %>%
    summarize_all(~sum(is.na(.)))
  print("Missing values:")
  print(missing_values)
  
  #Descriptive statistics for numeric variables
  numeric_summary <- df %>%
    summarise_if(is.numeric, list(
      Min = min, Max = max, Mean = mean, Median = median, SD = sd
    ), na.rm = TRUE)
  print("Descriptive statistics:")
  print(numeric_summary)
  
  #Distribution of categorical variables
  categorical_vars <- df %>% select(where(is.factor))
  
  if (ncol(categorical_vars) > 0) {
    categorical_summary <- categorical_vars %>%
      summarise_all(~n_distinct(.)) %>%
      pivot_longer(cols = everything(), names_to = "Variable", values_to = "Unique_Levels")
    
    print("Number of categories in categorical variables:")
    print(categorical_summary)
    
    print("Distribution of values in categorical variables:")
    categorical_long <- df %>%
      select(where(is.factor)) %>%
      pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value") %>%
      count(Variable, Value)
    
    print(categorical_long)
  } else {
    print("No categorical variables found in the dataset.")
  }
  
  #Display first 5 lines
  print("The dataset's first 5 lines:")
  print(head(df, 5))
  
  #Display data structure
  print("Data structure:")
  glimpse(df)
  
  #Distribution graph for numerical variables
  numeric_vars <- df %>% select_if(is.numeric)
  if (ncol(numeric_vars) > 0) {
    numeric_vars %>%
      gather(key = "Variable", value = "Value") %>%
      ggplot(aes(x = Value)) +
      geom_histogram(bins = 30, fill = "cornflowerblue", alpha = 0.6) +
      facet_wrap(~ Variable, scales = "free") +
      theme_minimal() +
      labs(title = "Histogram of Numeric Variables", x = "Value", y = "Count") %>%
      print()
  }
}

summarize_data(df)


### BONUS ###

skim_data <- function(df) {
  
  print("Detailed summary of data using skimr:")
  print(skim(df))
  
  print("Missing values:")
  missing_vals <- df %>%
    summarise_all(~sum(is.na(.))) %>%
    gather(key = "Variable", value = "Missing_Count") %>%
    mutate(Percent_Missing = round((Missing_Count / nrow(df)) * 100, 2))
  print(missing_vals)
  
  print("Summary of numeric variables:")
  numeric_summary <- df %>%
    select_if(is.numeric) %>%
    summarise_all(list(
      Min = min, Max = max, Mean = mean, Median = median, SD = sd, Skewness = ~e1071::skewness(.)
    ), na.rm = TRUE)
  print(numeric_summary)
}

skim_data(df)
