**Introduction to R – Final Assignment: Student Depression**


**Part 1: Defining The Research Question**

1.1 **Dataset.** 

The dataset of my choosing deals in the contributing factors to depression among students, and aims to both understand and predict changes in student’s depression. 
For this purpose, many factors were considered, among them: age, gender, sleep duration, work and academic pressure, dietary habits and more. 
I chose this dataset because, being a student myself, I believe it is crucial to map out the potential causes of depression among students and design intervention strategies accordingly. 
Students are often at an important juncture in their lives, on their way to building a career and a future of their own. Without proper care, depression could easily jeopardize that future. 

1.2 **Data exploration.**

Initial data exploration revealed most students are depressed. 
There was seemingly no difference in academic performance between depressed and non-depressed students.  
There was also no observed effect for a family history of mental illness, and no effect for gender. 
That said, depressed students seem to suffer more from financial stress, academic pressure, a lack of sleep, suicidal thoughts, an unhealthy diet and decreased study satisfaction. 
Depressed students also tend to be younger and appear to be working/studying for longer hours compared to their non-depressed counterparts.  

1.3 **Research question.**

What is the effect of financial stress and academic pressure on depression among students, and does pre-existing depression contribute to experiencing higher levels of these types of stress?

Based on the initial data exploration, I hypothesize financial stress and academic pressure to be leading causes in depression among students, with significant interaction between the two, 
so that higher levels of financial and academic stress lead to a higher rise in depression. 
I also estimate that students who have been long suffering from depression could be experiencing higher levels of financial and academic stress as a result of their already poor mental state. 


**Part 2: Pre-Processing**

2.1 **Defining variables.**
To test my hypothesis, I will use the following variables:

- Depression – dummy variable. 0 = no depression, 1 = depression.
- Financial stress – numeric variable. Financial stress is rated on a Likert scale of 1-5.
- Academic pressure – numeric variable. Academic pressure is rated on a Likert scale of 1-5.
- 
Financial stress and academic pressure were defined as numeric to allow for linear and logistic regression analysis. 

2.2 **Processing variables.**
The variables were processed using the dplyr package, creating an interaction variable, removing outliers, assessing the difference in financial and academic stress between depressed and 
non-depressed students in general and across different ages, and checking for correlations. 

2.3 **Original function.**
The purpose of this added function was to assess the quality of the data while checking for missing values, gathering descriptive statistics regarding numeric variables, 
displaying the distribution of categorical variables, displaying the data structure, and summarizing the data using graphs.  

2.4 **Bonus.** 
For the extra function, I used two new packages: “skimr” and “e1071”. Using these packages, my function was able to display a summary of the data that was more detailed than the usual 
use of summary() and easier to read compared to str(). Another advantage of these packages is the inclusion of additional information, such as skewness, 
which can be used to identify abnormal dispersion of numeric variables. 

**Part 3: Data Analysis**

3.1 **Linear and logistic regression.**
To test my hypothesis, I ran two linear regressions with depression as an independent variable, testing its effect first on financial stress and then on academic pressure. 
In addition, I ran a logistic regression where depression was the dependent variable, and the independent variables were financial stress, academic pressure, and the interaction between the two. 

3.2 **Results.**
The first linear regression shows students who suffer from depression tend to have significantly higher financial stress compared to students without depression. 
The average financial stress for students without depression and the lowest level of academic pressure is β0 = 2.58, while having depression raises financial stress by 1.09 units on average (β1=1.09, p<2e-16). 
Surprisingly, academic pressure had a significant negative effect on financial stress (β2=-0.028, p=2.01e-05).

The second linear regression presents a similar effect - students with depression are significantly more likely to experience higher academic pressure. 
The average academic pressure experienced by students without depression and the lowest level of financial stress is β0 = 2.42, while suffering from depression increases academic pressure by 1.35 units on average (β1=1.35, p<2e-16). 
Financial stress had a significant negative effect on academic pressure (β2=-0.023, p=2.01e-05).

The logistic regression found a significant effect for both financial stress and academic pressure, with academic pressure having a slightly stronger effect. 
The interaction between the two was not significant. 
The baseline log-odds of depression when financial stress and academic pressure are both at zero is β0 = -3.98. 
A single unit increase in financial stress raised the log-odds of depression by 0.587 (β1=0.587, p<2e-16). Converting the log-odds estimates into odds-ratio, this means that each unit of financial stress increases the odds of depression by 80% (exp(β1=1.8)). 
As for academic pressure, a single unit increase raised the log-odds of depression by 0.848 (β2=0.848, p<2e-16). In terms of odds-ratio, this means each 1-unit increase in academic pressure increases the odds of depression by 133%, thereby more than doubling it (exp(β2=2.33)). 

3.3 **Graphs.**
Graph 1 is a boxplot showing financial stress levels for students with and without depression. 
The median for those with depression is higher, supporting the linear regression’s findings.

Graph 2 is a boxplot showing academic pressure levels for students with and without depression. 
Similarly to graph 1, the median for depressed students is higher, supporting the results of the second linear regression.

Graphs 3 and 4 show the effects of financial stress and academic pressure on depression according to the logistic regression. 
In graph 3, the logistic regression curve represents the effect of financial stress on depression probability while the color gradient shows the effect of academic pressure (blue for low pressure, pink for high pressure). The logistic curve is higher and the dots are pinker for students with depression, supporting the logistic regression’s finding of two significant main effects. 
Graph 4 shows the same thing, except the logistic curve represents academic pressure and the color gradient represents financial stress. 

3.4 **ROC curve.**
The AUC value (Area Under the Curve) is 0.827, signaling the model has good predictive power and can effectively differentiate between students with and without depression. 
When selecting two random students, one with depression and the other without, the model will correctly identify the student’s depression 82.7% of the time. 


