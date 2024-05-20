# 1. Prepare packages: Choose one of the two R packages to install for performing CLR transformation. ====
install.packages("chemometrics")
install.packages("compositions")
install.packages("zCompositions")

#For introducing the function: melt() to change data format from wide to long.
library(reshape2)
#For data import
library(rio)
# Introduce function cmultRepl from package zCompositions to handle zero value.
library(zCompositions)

# 2. Import data ====
data <- import("Example_files/nmds_input_data.xlsx")
rownames(data) <- data$name
data <- data[-1]

# 3. Handle zero value: Special treatment for 0 ====
# Note: 'clr' cannot be used with non-positive data: use pseudocount > 0
data_z <- cmultRepl(data)

# Change wide format data into long format data to plot a histogram to observe the distribution of the data.
melt_data <- melt(data_z)
hist(melt_data$value)

# 4. CLR Transformation ====
# Method1: compositions::clr
data_clr <- compositions::clr(data_z)
data_clr <- as.data.frame(data_clr)
data_clr$sample <- rownames(data_clr)
export(data_clr,"Example_files/CLR_output_data.xlsx")
#Check the distribution of data
#Class of data_clr is rmult, but melt() can only deal with matrix.
data_clr <- as.matrix(data_clr)
melt_clr <- melt(data_clr)
hist(melt_clr$value)

#Method2: chemometrics::clr
data_clr_2 <- chemometrics::clr(data_z)
melt_clr_2 <- melt(data_clr_2)
hist(melt_clr_2$value)