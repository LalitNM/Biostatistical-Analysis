############################ Introduction #####################################
# Lalit Narayan Mudgal
# Roll Number: B19012
# Lab assignment 2
# BE303 - Applied Biostatistics
# IIT Mandi, India
##############################Basic code########################################

# Importing Libraries
library(ggplot2)
library(tidyr)
library(ggeasy)
library(epitools)
library(MASS)
library(readxl)
library(ggpubr)
library(dplyr)
library(tibble)
library(scales)

# Clearing all environment variables

rm (list = ls(all = T))


################################# 2.1 Two-way ANOVA ############################
# 2.1.1
Data_1 <-
  read_excel("C:/Users/Narayan/Downloads/BE303/Assignment-2/Data.xlsx",
             sheet = "Two_Way ANOVA")
df <-
  data.frame(Data_1)          # Arranging the dataset in a form (data.frame) that is manageable by R
View(df)
columns_list <- data.frame(df[2], df[3], df[4], df[5], df[6], df[7])
columns <- data.frame(Value = unlist(columns_list))

group <-
  c(
    rep("Placebo", 25),
    rep("Drug A", 25),
    rep("Drug B", 25),
    rep("Placebo", 25),
    rep("Drug A", 25),
    rep("Drug B", 25)
  )
factor <- c(rep("Exercise", 75), rep("Diet", 75))
columns['Group'] <- group
columns['Factor'] <- factor

columns <- columns %>% relocate(Value, .after = Value)
view(columns)

# 2.1.2
### 1 way ANOVA for Groups and Factors
anova2 <- aov(Value ~ group + factor, data = columns)
summary(anova2)

### 2 way ANOVA for Interaction between Factors and Groups
anova2_1 <- aov(Value ~ group * factor, data = columns)
anova2_1 <-
  aov(Value ~ group + factor + group:factor, data = columns)
summary(anova2_1)


# 2.1.3

# box plot
plt <- ggplot(data = columns, aes(x = Group, y = Value)) +
  geom_boxplot(aes(fill = Factor)) +
  labs(x = "Groups", y = "Cholesterol Level LDL [mg/L]", fill = "Factor") +
  ggtitle("Cholesterol Level of Different Groups") +
  theme_bw () +
  theme (
    axis.text = element_text(size = 12) ,
    axis.title = element_text(size = 12) ,
    plot.title = element_text(hjust = 0.5)
  )
plot (plt)


# interaction plot
interaction.plot(
  x.factor = columns$Group,
  trace.factor = columns$Factor,
  response = columns$Value,
  fun = mean,
  type = "b",
  legend = TRUE,
  xlab = "Groups",
  ylab = "Cholesterol Level LDL [mg/L]",
  main = "Interaction Plot",
  pch = c(1, 19),
  col = c("#FB8932", "#20B4FA")
)

# 2.1.4

tukeytest <-
  TukeyHSD(anova2, ordered = TRUE)  # post-hoc test (tukey test)
tukeytest


########################## 2.2 Linear Regression ###############################

# 2.2.5
Data_2 <-
  read_excel("C:/Users/Narayan/Downloads/BE303/Assignment-2/Data.xlsx",
             sheet = "Linear regression")

df2 <- data.frame(Data_2)
view(df2)

meanx <-
  mean(fd2$x)         # Calculating mean and variance of explanatory variable
varx <- var(df2$x)
meany <-
  mean(df2$y)         # Calculating mean and variance of dependent variable
vary <- var(df2$y)

meanx
varx
meany
vary

p2 <-
  ggplot(df2, aes(x = x, y = y)) + geom_point() +                            #scatter plot
  labs(title = "Cholesterol Level and Animal Weight Scatter Plot", x = "Weight of animal species [mg]", y =
         "Cholesterol level LDL [mg/L]") +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
plot(p2)

# 2.2.6
#Using glm command to analyse the standard linear model
model <- glm(df2$y ~ df2$x, data = df2)
summary(model)

# 2.2.7
m <- (sum((x - meanx) * (y - meany))) / (sum((x - meanx) ^ 2))
b <- meany - m * meanx
regression <- m * x + b

#computing Standard Errors (SE)
RSS <- sum((regression - y) ^ 2)
SEm <-  sqrt((RSS) / ((length(y) - 2) * sum((x - meanx) ^ 2)))

fac1 <- RSS / (length(y) - 2)
sum1 <- 1 / length(y)
sum2 <- meanx ^ 2 / (sum((x - meanx) ^ 2))
SEb <-  sqrt(fac1 * (sum1 + sum2))

# computing confidence intervals with alpha = 5% and df = 98
CI_mmax <- m + qt(0.995, 98) * SEm
CI_mmin <- m - qt(0.995, 98) * SEm

CI_bmax <- b + qt(0.995, 98) * SEb
CI_bmin <- b - qt(0.995, 98) * SEb

CI_mmax                       # confidence interval for m
CI_mmin
CI_bmax                       # confidence interval for b
CI_bmin

# 2.2.8
x = df2$x
y = df2$y
Reg_max <-
  CI_bmax + CI_mmin * x   #linear regression with larger slope and smaller y-intercept
Reg_min <-
  CI_bmin + CI_mmax * x   #linear regression with smaller slope

p3 <- ggplot() +
  geom_point(aes(x = x, y = y)) +                         #scatter Plot
  geom_line(aes(x = x, y = regression), color = "blue") + #optimal regression line
  geom_line(aes(x = x, y = Reg_max), color = "red") +     #regression with upper-limit slope
  geom_line(aes(x = x, y = Reg_min), color = "red") +     #regression with lower-limit slope
  geom_smooth(aes(x = x, y = y), method = lm) +           #auto-generated slope
  stat_regline_equation(aes(x = x, y = y)) +              #inserting regression equation
  theme_bw() +
  labs(x = "Weight of animal species  [mg]",
       y = "Cholesterol level LDL [mg/L]") +
  ggtitle("Cholesterol Level Dependence on Animal Weight") +
  theme(
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12),
    plot.title = element_text(hjust = 0.5, face = "bold")
  )
plot(p3)


# 2.2.9
plot(
  x,
  resid(model),
  pch = 16,
  #scatter plot of residuals
  xlab = "Weight of animal species [mg]",
  ylab = "Residuals",
  main = "Scatter Plot of Residuals"
)

abline(h = 0,
       lwd = 2,
       lty = 2,
       col = "blue")
