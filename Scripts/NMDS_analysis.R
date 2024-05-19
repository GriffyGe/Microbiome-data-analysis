# 1. Packages preparation ====
library(rio)           # i/o of data
library(vegan)         # statistical analysis: metaNMDS(), decostand()
library(tidyverse)     # ggplot2() to visualize data
library(ggalt)

# 2. Data input and standardization ====
group <- import('Example_files/nmds_input_data.xlsx',sheet = 2)
abundance <- import('Example_files/nmds_input_data.xlsx', sheet = 1)
rownames(abundance) <- abundance$name
abundance <- abundance[,-1]
abundance.h <- decostand(abundance,method = 'hellinger')

# 3. NMDS analysis ====
NMDS <- metaMDS(abundance.h,k=2,trymax = 100)

# 4. Extract data for visualization ====

#Extract data ordered point coordinates.
sample_site <- data.frame(NMDS$points)
colnames(sample_site) <- c('NMDS1','NMDS2')
sample_site$sample <- rownames(sample_site)
#Get grouping info
sample_site <- merge(sample_site,group,by='sample') #Final data for plotting

export(sample_site,'Example_files/nmds_output_sample_site.csv')

# 5. Plotting ====
ggplot(sample_site,aes(NMDS1,NMDS2,group=group))+
  geom_point(aes(color = group),size = 1.5)+
  #link the points with lines
  geom_encircle(aes(fill = group, color = group),
                s_shape = 1,expand = 0, alpha = 0.3)+
  
  scale_color_brewer(palette = 'Set1')+
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = paste('Stress=',round(NMDS$stress,4))) +
  #Make title center alignment
  theme(plot.title = element_text(hjust = 0.5))
