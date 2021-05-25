# Following Results were Obtained
## Two-way ANOVA

- Few entries of the required dataframe (3X150)

  ![image](https://user-images.githubusercontent.com/63332774/139120202-d1098f7d-f37c-4f8e-9ec6-d4e1305ddd27.png)

- #1 way ANOVA for Groups and Factors

  ![image](https://user-images.githubusercontent.com/63332774/139120394-acb55799-6560-472c-b850-2b2b96db7085.png)

  #2 way ANOVA for Interaction between Factors and Groups

  ![image](https://user-images.githubusercontent.com/63332774/139120482-0003b7a9-6181-46f7-9d58-90766a23fe88.png)

  Analysis: We conclude that Group and Factor are significant as their p-value < 0.05. However, the interaction between Factor and Group is not significant (0.168 > 0.05).

- Box Plot:

  ![image](https://user-images.githubusercontent.com/63332774/139120733-bcb6e09c-c60f-40cc-9667-2bc3808dc797.png)

  Interaction plot

  ![image](https://user-images.githubusercontent.com/63332774/139120822-cb7d3a38-22ed-441d-aa9d-113727a29b63.png)

  From here also we can say that Group and Factor are significant and the interaction between Factor and Group is not significant.

  Gi ≠ 0

  Fj ≠ 0

  (G X F)ij = 0

- Tukey-test

  ![image](https://user-images.githubusercontent.com/63332774/139121022-7c1bfb84-543e-444e-8ac1-fbcbea77590b.png)

  Placebo and Drug B significantly differ from each other. Placebo also differs from Drug A. We can say that Placebo gives a significant effect on cholesterol level LDL.


## Linear Regression

- Mean of x: 1201.623

  Var of x: 250.8409

  Mean of y: 1569.167

  Var of y: 31793.34

  Scatter-plot of data

  ![image](https://user-images.githubusercontent.com/63332774/139121254-d2f79286-7f8e-48d9-a3f0-43f60ba4f8c8.png)

- Output:

  ![image](https://user-images.githubusercontent.com/63332774/139121476-13ffca48-c990-4a82-a7cf-a63241f6645c.png)

  This linear model can’t be used for any value of x other than this dataset because this model is trained on this dataset only i.e., it has its own m and b values.For different dataset values of ‘m’ and ‘b’ will be different.

- Confidence interval for m is [-11.01163, -7.680362]

  Confidence interval for b is [10797.89, 14801.17]


- Scatter plot with regression line and confidence interval:

  ![image](https://user-images.githubusercontent.com/63332774/139121724-7e139be7-468c-49fc-a283-4311fe2c3e57.png)
