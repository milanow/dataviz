library(igraph)
library(cluster)
library(ggplot2)
setwd("/Users/tianhewang/Desktop/ANLY512/Assignment5")

nodes <- read.csv("nodes.csv", quote = "\"", header = TRUE)
edges <- read.csv("edges.csv", quote = "\"", header = TRUE)
g1 <-graph_from_data_frame(d=edges, vertices=nodes, directed=FALSE)
g2 <-graph_from_data_frame(d=edges, vertices=nodes, directed=FALSE)
g3 <-graph_from_data_frame(d=edges, vertices=nodes, directed=FALSE)

#par(mar=c(0, 0, 0, 0))
#plot(g,
#     vertex.color = "grey", # change color of nodes
#     vertex.label.color = "black", # change color of labels
#     vertex.label.cex = .75, # change size of labels to 75% of original size
#     edge.curved=.25, # add a 25% curve to the edges
#     edge.color="grey20") # change edge color to grey

V(g1)$size <- log(strength(g1)) * 6
par(mar=c(0, 0, 0, 0))
V(g1)$color <- NA
V(g1)$color <- ifelse(V(g1)$sex == "Male", "lightblue", "pink")
plot(g1,
     vertex.label.color = "black", # change color of labels
     vertex.label.cex = .75, # change size of labels to 75% of original size
     edge.curved=.25, # add a 25% curve to the edges
     #layout=layout_in_circle, main="Circle",
     edge.color="grey20") # change edge color to grey
legend(x = 0.7, y = 0.9, legend = c("Male", "Female", "Don't Know"),
       pch = 21, pt.bg = c("lightblue", "pink", "white"))

par(mfrow=c(1,2))
set.seed(777)
fr <- layout_with_fr(g2, niter=1000)
E(g2)$color <- NA
E(g2)$color <- ifelse(E(g2)$sf == "Yes", "red", "green")
                      #ifelse(E(g2)$sf == "No", "green", "black"))
plot(g2, layout=fr,
     vertex.color = "yellow",
     vertex.label.color = "black", # change color of labels
     vertex.label.cex = .75, # change size of labels to 75% of original size
     edge.curved=.25) # add a 25% curve to the edges

legend(x = 0.7, y = 0.9, legend = c("Same Industry", "Not Same Industry"),
       pch = 21, pt.bg = c("red", "green"))


par(mar=c(0, 0, 0, 0))
set.seed(3545)
# Community detection (by optimizing modularity over partitions):
clp <- cluster_optimal(g3)
class(clp)

# Community detection returns an object of class "communities" 
# which igraph knows how to plot: 
plot(clp, g3,
     vertex.label.color = "black",
     vertex.label.cex = .75)

#####################
bet <- betweenness(g3)