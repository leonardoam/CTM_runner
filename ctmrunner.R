require("tm")
require("topicmodels")

args <- commandArgs(TRUE)
if (length(args) != 3)
	stop("usage: Rscript ctmrunner.R <inputdir> <outputfile> <k>")
corpus <- Corpus(DirSource(args[1]))
print("Finish reading files...")
dtm <- DocumentTermMatrix(corpus, control=list(minDocFreq=2, minWordLength=2))
freq <- apply(dtm>0,2,sum)
dtm <- dtm[,freq>9]
cnt <- apply(dtm,1,sum)
dtm <- dtm[cnt>9,]
ctm <- CTM(dtm, as.numeric(args[3]), iter.max=20)
save.image(paste(args[2], ".RData", sep=""), compress=TRUE)
