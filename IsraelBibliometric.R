#####Bibliometric Analysis######

###Libraries####
library(litsearchr)
library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(bibliometrix)#install.packages("bibliometrix")
library(revtools)
library(synthesisr)

######Load data#######

#Using the Bibliometrix
#Scopus <- convert2df("scopus.bib", dbsource = "scopus", format = "bibtex")##Este tiene menos columnas que los otros##This one has fewer columns than the others
#Wos <- convert2df("webofscience.bib", dbsource = "wos", format = "bibtex")

#MergedDB <- mergeDbSources(Wos, Scopus,  remove.duplicated=T)
##
#write_bib(as.data.frame(MergedDB))

#write.csv(MergedDB, "Merged and cleaned database for literature review.csv")

MergedDB <- read.csv("Merged and cleaned database for literature review.csv")

str(MergedDB)
dim(MergedDB)
###Comando para resumir los resultados del analisis bibliografico##Command to summarize the results of the bibliographic analysis
General.results <- biblioAnalysis(MergedDB, sep = ";")##falta la afiliación de los autores##the authors' affiliation is missing
G.Results<-summary(General.results)


###identification of the history and evolution of the topic
###Identificar los papers principales e irlos pasando a los chicos
MergedDB$CR<-MergedDB$CR_raw

historia.First.Search<-histNetwork(MergedDB, sep = ";")
histPlot(historia.First.Search, n=50)


Evolucion_temas<-biblioNetwork(MergedDB, analysis = "collaboration",
                               network = "authors", sep = ";")


plot(Evolucion_temas)


Network_temas<-biblioNetwork(MergedDB, analysis = "co-occurrences",
                             network = "keywords", sep = ";") #this doesnt work



#####Aquí vamos esto de a continuación es muy interesante#####Here we go, this next thing is very interesting.
bibliometrix::thematicMap(MergedDB)
bibliometrix::threeFieldsPlot(MergedDB)
CS <- conceptualStructure(MergedDB, field="ID", method="CA",
                          stemming=FALSE, minDegree=5, k.max = 50)

bibliometrix::missingData(MergedDB)