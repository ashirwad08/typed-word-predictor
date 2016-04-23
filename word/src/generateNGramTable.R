
library(quanteda)
library(data.table)


genTriGrams <- function(filepath){
        
        blogs <- readLines(paste0(filepath,"en_US.blogs.txt"), encoding='UTF-8')
        news <- readLines(paste0(filepath,"en_US.news.txt"), encoding='UTF-8')
        tweets <- readLines(paste0(filepath,"en_US.twitter.txt"), encoding = 'UTF-8')
        
        blogs <- sample(blogs, size = length(blogs)*0.065)
        news <- sample(news, size = length(news)*0.05)
        tweets <- sample(tweets, size = length(tweets)*0.1)
        
        
        
        #try to preserve morphemes (can't, isn't, won't, i'm, by removing ')
        #remove punctuation and numbers
        blogs <- gsub('[[:punct:]|[:digit:]]', " ", gsub('\'', '', blogs))
        news <- gsub('[[:punct:]|[:digit:]]', " ", gsub('\'', '', news))
        #also remove all hashtags from twitter corpus... 
        tweets <- gsub('[[:punct:]|[:digit:]]', " ", 
                       gsub('#[[:alpha:]|[:digit:]]+',"", 
                            gsub('\'', '', tweets)))
        
        
        corp <- c(blogs, news, tweets)
        
        #unigrams
#         dfm1 <- dfm(corp, 
#                      removeSeparators = TRUE, 
#                      ngrams=1)
#         sortFreq <- sort(colSums(dfm1), decreasing = TRUE)
#         unigramDT <- data.table(unigrams = names(sortFreq), freq = sortFreq)
#         saveRDS(unigramDT, "./data/unigramDT.rds", compress = TRUE)
        
        #bigrams
        dfm2 <- dfm(corp, 
                    removeSeparators = TRUE, 
                    ngrams=2)
        sortFreq <- sort(colSums(dfm2), decreasing = TRUE)
        bigramDT <- data.table(bigrams = names(sortFreq), freq = sortFreq)
        saveRDS(bigramDT, "./data/bigramdt.rds", compress = TRUE)
        
        #trigrams
        dfm3 <- dfm(corp, 
                    removeSeparators = TRUE, 
                    ngrams=3, skipgrams=0:2)
        sortFreq <- sort(colSums(dfm3), decreasing = TRUE)
        trigramDT <- data.table(trigrams = names(sortFreq), freq = sortFreq)
        saveRDS(trigramDT, "./data/trigramdt.rds", compress = TRUE)
        
        
        
        
        rm(list=c('sortFreq','dfm1','dfm2','dfm3','corp','unigramDT','bigramDT','trigramDT'))
        
        
        
#         testcorp <- corpus(textfile('~/Downloads/final/en_US/*.txt', encoding="UTF-8"))
#         
#         samp <- sample(testcorp, size=testcorp*.001, replace=FALSE) 
        
        
        #samp <- sample(testcorp[1], size=, replace=FALSE)
        
}