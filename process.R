library(ggplot2)
library(seqinr)
source("/home/jon/Programming/R/mmsf/multiplot.R")
source("/home/jon/Programming/R/mmsf/alignment.R")
source("/home/jon/Programming/R/mmsf/protscale.R")

seqnames <- c("Q2W8R4","Q2W8R8","Q2W8J5")  # Make a vector containing the names of the sequences
seqs <- retrieveseqs(seqnames,"swissprot")  #http://a-little-book-of-r-for-bioinformatics.readthedocs.org/en/latest/src/chapter5.html
hydrop_mmsf <- protscale("Q2W8R4",length(seqs[[1]]))
hydrop_0953 <- protscale("Q2W8R8",length(seqs[[3]]))
hydrop_1026 <- protscale("Q2W8J5",length(seqs[[5]]))

seq_data_mmsf <- data.frame(c(1:length(seqs[[1]])),seqs[[1]])
seq_data_0953 <- data.frame(c(1:length(seqs[[3]])),seqs[[3]])
seq_data_1026 <- data.frame(c(1:length(seqs[[5]])),seqs[[5]])

colnames(seq_data_mmsf) <- c("Position","AA")
colnames(seq_data_0953) <- c("Position","AA")
colnames(seq_data_1026) <- c("Position","AA")

data_mmsf <- merge(hydrop_mmsf,seq_data_mmsf, by="Position")
data_0953 <- merge(hydrop_0953,seq_data_0953, by="Position")
data_1026 <- merge(hydrop_1026,seq_data_1026, by="Position")

p1 <- ggplot(data_mmsf, aes( Position, Value )) + ggtitle("amb0957 mmsF") + geom_line() + scale_y_continuous("Hydropathy Index",limits=c(-3, 3)) + scale_x_continuous("Sequence Position",limits=c(0, 110))
p2 <- ggplot(data_1026, aes( Position, Value )) + ggtitle("amb1026") + geom_line() + scale_y_continuous("Hydropathy Index",limits=c(-3, 3)) +  scale_x_continuous("Sequence Position",limits=c(0, 110))
p3 <- ggplot(data_0953, aes( Position, Value )) + ggtitle("amb0953") + geom_line() + scale_y_continuous("Hydropathy Index",limits=c(-3, 3)) + scale_x_continuous("Sequence Position",limits=c(0, 110))

multiplot(p1, p2, p3, cols=1)

