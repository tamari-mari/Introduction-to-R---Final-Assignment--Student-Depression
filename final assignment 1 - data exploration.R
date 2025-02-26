# R course for beginners
# Final Assignment
# assignment by Tamari Geron, id 314833195



### SCRIPT 1 - Exploration of Data ###


#loading data
df <- read.csv("C:\\Users\\tamar\\Documents\\University\\Psychology 2\\R\\מטלה סופית\\Student Depression Dataset.csv", header = TRUE)


#first look at data
head(df)
glimpse(df)
summary(df)


#missing values
colSums(is.na(df))
na.omit(df)


#factors and contrasts
Depression_factor <- as.factor(df$Depression)
contrasts(Depression_factor) <- c(0,1)
contrasts(Depression_factor)

Family_History <- as.factor(df$Family.History.of.Mental.Illness)
contrasts(Family_History) <- c(0,1)
contrasts(Family_History)

Suicidal_Thoughts <- as.factor(df$Have.you.ever.had.suicidal.thoughts..)
contrasts(Suicidal_Thoughts) <- c(0,1)
contrasts(Suicidal_Thoughts)

Gender <- as.factor(df$Gender)
contrasts(Gender) <- c(1,0)
contrasts(Gender)

Sleep <- factor(df$Sleep.Duration, 
                   levels = c("Less than 5 hours", "5-6 hours", "7-8 hours", "More than 8 hours" ), 
                   ordered = TRUE)
summary(Sleep)

Diet <- factor(df$Dietary.Habits, 
               levels = c("Unhealthy", "Moderate", "Healthy"), 
               ordered = TRUE)
summary(Diet)


### PLOTTING THE DATA ###


#Depression distribution
ggplot(df, aes(x = Depression_factor, fill = Depression_factor)) +
  geom_bar(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Depression Distribution",
       x = "Depression",
       y = "Amount")

#Age
ggplot(df, aes(x = Depression_factor, y = Age, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.5) +
  theme_minimal() +
  labs(title = "Age Differences between Depressed and Non-Depressed Students",
       x = "Depression",
       y = "Age") +
  scale_fill_manual(values = c("orangered", "deepskyblue1"))

ggplot(df, aes(x = Depression_factor, y = Age, fill = Depression_factor)) +
  stat_halfeye(alpha = 0.6, adjust = 0.8, justification = -0.2) +
  theme_minimal() +
  labs(title = "Depression Distribution by Age",
       x = "Depression",
       y = "Age") +
  scale_fill_manual(values = c("orangered", "deepskyblue1"))


#Gender
ggplot(df, aes(x = Depression_factor, fill = Gender)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  labs(title = "Proportion of Gender by Depression",
       x = "Depression",
       y = "Proportion") +
  scale_fill_manual(values = c("maroon", "goldenrod"))

ggplot(df, aes(x = Depression_factor, fill = Gender)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Depression and Gender",
       x = "Depression",
       y = "Count") +
  scale_fill_manual(values = c("maroon", "goldenrod"))


#CGPA
ggplot(df, aes(x = Depression_factor, y = CGPA, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.5) +
  theme_minimal() +
  labs(title = "CGPA Differences between Depressed and Non-Depressed Students",
       x = "Depression",
       y = "CGPA") +
  scale_fill_manual(values = c("thistle2", "goldenrod1"))

ggplot(df, aes(x = Depression_factor, y = CGPA, fill = Depression_factor)) +
  geom_violin(alpha = 0.6, scale = "width") +
  theme_minimal() +
  labs(title = "Violin Plot of CGPA by Depression",
       x = "Depression",
       y = "CGPA") +
  scale_fill_manual(values = c("thistle2", "goldenrod1"))


#Financial Stress (1-5)
df$Financial.Stress <- as.numeric(as.character(df$Financial.Stress))

ggplot(df, aes(x = factor(Financial.Stress), fill = Depression_factor)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Distribution of Financial Stress by Depression",
       x = "Financial Stress (1-5)",
       y = "Count") +
  scale_fill_manual(values = c("plum", "mediumpurple3"))

ggplot(df, aes(x = Depression_factor, y = Financial.Stress, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Financial Stress Comparison by Depression",
       x = "Depression",
       y = "Financial Stress (1-5)") +
  scale_fill_manual(values = c("plum", "mediumpurple3"))

ggplot(df, aes(x = Depression_factor, y = Financial.Stress, fill = Depression_factor)) +
  stat_halfeye(alpha = 0.6, adjust = 0.8, justification = -0.2) +
  theme_minimal() +
  labs(title = "Financial Stress Distribution by Depression",
       x = "Depression",
       y = "Financial Stress (1-5)") +
  scale_fill_manual(values = c("plum", "mediumpurple3"))


#Academic Pressure (1-5)
df$Academic.Pressure <- as.numeric(as.character(df$Academic.Pressure))

ggplot(df, aes(x = factor(Academic.Pressure), fill = Depression_factor)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Distribution of Academic Pressure by Depression",
       x = "Academic Pressure (1-5)",
       y = "Count") +
  scale_fill_manual(values = c("lightcoral", "turquoise3"))

ggplot(df, aes(x = Depression_factor, y = Academic.Pressure, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Academic Pressure Comparison by Depression",
       x = "Depression",
       y = "Academic Pressure (1-5)") +
  scale_fill_manual(values = c("lightcoral", "turquoise3"))

ggplot(df, aes(x = Depression_factor, y = Academic.Pressure, fill = Depression_factor)) +
  stat_halfeye(alpha = 0.6, adjust = 0.8, justification = -0.2) +
  theme_minimal() +
  labs(title = "Academic Pressure Distribution by Depression",
       x = "Depression",
       y = "Academic Pressure (1-5)") +
  scale_fill_manual(values = c("lightcoral", "turquoise3"))


#Sleep Duration
ggplot(df, aes(x = Sleep, fill = Depression_factor)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Depression Distribution by Sleep Duration",
       x = "Sleep Duration",
       y = "Count") +
  scale_fill_manual(values = c("gold", "salmon"))

ggplot(df, aes(x = Sleep, fill = Depression_factor)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  labs(title = "Proportion of Depression by Sleep Duration",
       x = "Sleep Duration",
       y = "Proportion") +
  scale_fill_manual(values = c("gold", "salmon"))

ggplot(df, aes(x = Sleep, y = Depression_factor, color = Depression_factor)) +  
  geom_jitter(width = 0.2, height = 0.05, alpha = 0.6, size = 2) +
  theme_minimal() +
  labs(title = "Depression Distribution by Sleep Duration",
       x = "Sleep Duration",
       y = "Depression (0 = No, 1 = Yes)") +
  scale_color_manual(values = c("gold", "salmon"))  


#Family History (0,1)
ggplot(df, aes(x = Depression_factor, fill = Family_History)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  labs(title = "Proportion of Family History by Depression",
       x = "Depression",
       y = "Proportion") +
  scale_fill_manual(values = c("coral", "pink"))


#Suicidal Thoughts (0,1)
ggplot(df, aes(x = Depression_factor, fill = Suicidal_Thoughts)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  labs(title = "Proportion of Suicidal Thoughts by Depression",
       x = "Depression",
       y = "Proportion") +
  scale_fill_manual(values = c("violet", "skyblue1"))

ggplot(df, aes(x = Depression_factor, fill = Suicidal_Thoughts)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Depression and Suicidal Thoughts",
       x = "Depression",
       y = "Count") +
  scale_fill_manual(values = c("violet", "skyblue1"))


#Work/Study Hours
ggplot(df, aes(x = Depression_factor, y = Work.Study.Hours, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Work/Study Hours Distribution by Depression",
       x = "Depression",
       y = "Work/Study Hours") +
  scale_fill_manual(values = c("blueviolet", "royalblue"))

ggplot(df, aes(x = Depression_factor, y = Work.Study.Hours, fill = Depression_factor)) +
  stat_halfeye(alpha = 0.6, adjust = 0.8, justification = -0.2) +
  theme_minimal() +
  labs(title = "Depression Distribution by Work/Study Hours",
       x = "Depression",
       y = "Work/Study Hours") +
  scale_fill_manual(values = c("blueviolet", "royalblue"))

ggplot(df, aes(x = Depression_factor, y = Work.Study.Hours, fill = Depression_factor)) +
  geom_violin(alpha = 0.6, scale = "width") +
  theme_minimal() +
  labs(title = "Violin Plot of Work/Study Hours by Depression",
       x = "Depression",
       y = "Work/Study Hours") +
  scale_fill_manual(values = c("blueviolet", "royalblue"))


#Dietary Habits
ggplot(df, aes(x = Diet, fill = Depression_factor)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Depression Distribution by Diet",
       x = "Diet",
       y = "Count") +
  scale_fill_manual(values = c("mistyrose1", "rosybrown3"))

ggplot(df, aes(x = Diet, fill = Depression_factor)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  labs(title = "Proportion of Depression by Diet",
       x = "Diet",
       y = "Proportion") +
  scale_fill_manual(values = c("mistyrose1", "rosybrown3"))

ggplot(df, aes(x = Diet, y = Depression_factor, color = Depression_factor)) +  
  geom_jitter(width = 0.2, height = 0.05, alpha = 0.6, size = 2) +
  theme_minimal() +
  labs(title = "Depression Distribution by Diet",
       x = "Diet",
       y = "Depression (0 = No, 1 = Yes)") +
  scale_color_manual(values = c("mistyrose1", "rosybrown3")) 


#Study Satisfaction (1-5)
df$Study.Satisfaction <- as.numeric(as.character(df$Study.Satisfaction))

ggplot(df, aes(x = factor(Study.Satisfaction), fill = Depression_factor)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Distribution of Study Satisfaction by Depression",
       x = "Study Satisfaction (1-5)",
       y = "Count") +
  scale_fill_manual(values = c("lightskyblue", "lightslateblue"))

ggplot(df, aes(x = Depression_factor, y = Study.Satisfaction, fill = Depression_factor)) +
  geom_boxplot(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Study Satisfaction Comparison by Depression",
       x = "Depression",
       y = "Study Satisfaction (1-5)") +
  scale_fill_manual(values = c("lightskyblue", "lightslateblue"))

ggplot(df, aes(x = Depression_factor, y = Study.Satisfaction, fill = Depression_factor)) +
  stat_halfeye(alpha = 0.6, adjust = 0.8, justification = -0.2) +
  theme_minimal() +
  labs(title = "Study Satisfaction Distribution by Depression",
       x = "Depression",
       y = "Study Satisfaction (1-5)") +
  scale_fill_manual(values = c("lightskyblue", "lightslateblue"))
