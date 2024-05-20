# 1. Prepare packages ====
library(rio)
#Introduce function PCA()
library(FactoMineR)
#Introduce functions of data analysis and plotting
library(tidyverse)

# 2. Import data. ====
group <- import('Example_files/nmds_input_data.xlsx',sheet = 2)
data <- import("Example_files/CLR_output_data.xlsx")
rownames(data) <- data$sample
data <- data %>% dplyr::select(-sample)

# 3. PCA analysis ====
gene.pca <- PCA(data,ncp = 2,graph = FALSE)

# 4. Extract data for visualization ====

#Extract data ordered point coordinates
pca_sample <- data.frame(gene.pca$ind$coord)
pca_sample$sample <- rownames(pca_sample)
#Add grouping info
pca_sample <- merge(group, pca_sample, by = "sample")
#Extract percentage of variance of the first two comp
pca_eig1 <- round(gene.pca$eig[1,2],2)
pca_eig2 <- round(gene.pca$eig[2,2],2)

# 5. Plotting ====
ggplot(data = pca_sample,
       mapping = aes(Dim.1,Dim.2,color=group, fill = group))+
  geom_point(size=3.5)+
  geom_encircle(s_shape = 1,expand = 0, alpha = 0.3) +
  geom_hline(aes(yintercept=0),colour="grey",linetype=5, lwd = 1/.pt)+
  geom_vline(aes(xintercept=0),colour="grey",linetype=5, lwd = 1/.pt)+
  
  scale_color_brewer(palette = 'Set1')+
  scale_fill_brewer(palette = 'Set1')+

  labs(x=paste("PCA 1 (", pca_eig1, "%)", sep=""),
       y=paste("PCA 2 (", pca_eig2, "%)", sep="")) +
  
  theme_bw()+
  theme(panel.grid = element_blank())
