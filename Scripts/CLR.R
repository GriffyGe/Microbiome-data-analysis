# 1. Package prep: Choose one of the two R packages to install for performing CLR transformation. ====
install.packages("chemometrics")
install.packages("compositions")

#For introducing the function: melt() to change data format from wide to long.
library(reshape2)
#For data import
library(rio)

data <- import("XXX.xlsx")

# 2. Zero value treatment: Special treatment for 0 ====
# Note: 'clr' cannot be used with non-positive data: use pseudocount > 0
# Introduce function cmultRepl from package zCompositions to handle zero value.
install.packages("zCompositions")
library(zCompositions)
data_z <- cmultRepl(data)

# Change wide format data into long format data to plot a histogram to observe the distribution of the data.
melt_data <- melt(data_z)
hist(melt_data$value)

# 3. CLR Transformation====
# Method1: compositions::clr
data_clr <- compositions::clr(data_z)
export(data_clr,"CLR_data.xlsx")
#Check the distribution of data
#Class of data_clr is rmult, but melt() can only deal with matrix.
data_clr <- as.matrix(data_clr)
melt_clr <- melt(data_clr)
hist(melt_clr$value)

#Method2: chemometrics::clr
data_clr_2 <- chemometrics::clr(data_z)
melt_clr_2 <- melt(data_clr_2)
hist(melt_clr_2$value)