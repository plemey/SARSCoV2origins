
library(tidyverse)
library(pheatmap)
library(viridis)
library(ggrepel)
library(ggpmisc)



# RSCU Heatmap ------------------------------------------------------------

all_rscu <- read_csv('all_rscu_codonBiasReanalysis.csv')

all_df <- as.data.frame(all_rscu[,2:26])
row.names(all_df) <- all_rscu$codon

pheatmap(all_df,
         cluster_rows = F,
         scale = 'none',
         fontsize_row = 5,
         fontsize_col = 10,
         color = magma(50),
         border_color = NA,
         cutree_cols = 4
         )



# PCA ---------------------------------------------------------------------

df_pca <- prcomp(t(all_df))

subset_viruses <- c('MG772934','MG772933','GU190215','KP886808','KP886809','MN908947')

df_out <- as.data.frame(df_pca$x)
df_out$group <- ifelse(row.names(df_out) %in% subset_viruses,'virus','vertebrate')
df_out$species <- row.names(df_out)

ggplot(df_out,aes(x=PC1,y=PC2,color=group)) +
  geom_point(show.legend = F) +
  scale_color_manual(values = c('dodgerblue4','firebrick')) +
  geom_label_repel(aes(label = species),show.legend = F) +
  theme_bw() + theme(aspect.ratio = 1, panel.grid = element_blank())

ggplot(df_out,aes(x=PC3,y=PC4,color=group)) +
  geom_point(show.legend = F) +
  scale_color_manual(values = c('dodgerblue4','firebrick')) +
  geom_label_repel(aes(label = species),show.legend = F) +
  theme_bw() + theme(aspect.ratio = 1, panel.grid = element_blank())



# Snake - bat - virus PCA -------------------------------------------------

taxa <- c('MG772934','MG772933','GU190215','KP886808','KP886809','MN908947','Rhonolophus sinicus','Deinagkistrodon','King_cobra','Garter_snake','Burmese_python','Bungarus multicinctus', 'Naja atra')

subset_df <- as.data.frame(t(all_df)) %>% 
  rownames_to_column() %>% 
  filter(rowname %in% taxa)

subset_df_pca <- prcomp(subset_df[,-1])

subset_df_out <- as.data.frame(subset_df_pca$x)
subset_df_out$species <- subset_df$rowname
subset_df_out <- subset_df_out %>% 
  mutate(type = ifelse(species == 'Rhonolophus sinicus','Bat','Snake')) %>% 
  mutate(type = ifelse(species == 'MN908947','2019-nCoV',type)) %>% 
  mutate(type = ifelse(species %in% c('MG772933','GU190215','KP886808','KP886809','MG772934'),'Bat Virus',type))


ggplot(subset_df_out,aes(x=PC1,y=PC2,color=type)) +
  geom_point(show.legend = T) +
  scale_color_manual(values = c('seagreen','firebrick','darkorange','black')) +
  geom_label_repel(aes(label = species),show.legend = F) +
  theme_bw() + theme(aspect.ratio = 1, panel.grid = element_blank())



##

temp_df <- as.matrix(dist(t(all_df))^2)

temp_df <- as.data.frame(temp_df,row.names = row.names(temp_df)) %>% 
  select(MN908947) %>% 
  rownames_to_column() %>% 
  arrange(MN908947) %>% 
  mutate(species = factor(rowname)) %>% 
  filter(MN908947 > 9) %>% 
  mutate(species = fct_reorder(species, MN908947)) %>% 
  mutate(new_low = ifelse(MN908947 < 12,'yes','no'))



gc_all <- readxl::read_xlsx('GC_Content.xlsx') %>% 
  select(species = Species,GC = 3)


GC_dist <- temp_df %>% 
  left_join(gc_all) %>% 
  filter(!is.na(GC)) %>% 
  mutate(GC = as.numeric(GC)) %>% 
  mutate(deltaGC = GC - 0.37957 )

ggplot(GC_dist,aes(x=deltaGC,y=MN908947)) +
  geom_point() +
  geom_label_repel(aes(label=species))+
  geom_smooth(method = 'lm',formula = y ~ x,se = F,lty=2,lwd=0.5,alpha=0.6) +
  stat_fit_glance(method = "lm", 
                  method.args = list(formula = y ~ x),
                  label.x = "right",
                  label.y = "bottom",
                  aes(label = paste("italic(P)*\"-value = \"*", 
                                    signif(..p.value.., digits = 4), sep = "")),
                  parse = TRUE)+
  ylab('Squared Euclidean Distance') +
  xlab('Delta GC Content (%) (Species - 2019 nCoV)') +
  theme_classic() + theme(aspect.ratio = 1)




