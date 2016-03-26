library(data.table)
library(stringi)

filepath <- "/Users/ash/Downloads/final/en_US/"

processData <- function(filepath){
        blogs <- stri_flatten(readLines(paste0(filepath,"en_US.blogs.txt"), encoding='UTF-8'))
        news <- stri_flatten(readLines(paste0(filepath,"en_US.news.txt"), encoding='UTF-8'))
        tweets <- stri_flatten(readLines(paste0(filepath,"en_US.twitter.txt"), encoding = 'UTF-8'))
        
        #try to preserve morphemes (can't, isn't, won't, i'm, by removing ')
        blogs <- gsub('\'', '', blogs)
        news <- gsub('\'', '', news)
        tweets <- gsub('\'', '', tweets)
        
        #remove punctuation and numbers
        blogs <- gsub('[[:punct:]|[:digit:]]', " ", blogs)
        news <- gsub('[[:punct:]|[:digit:]]', " ", news)
        #also remove all hashtags from twitter corpus... !!!pending!!!
        tweets <- gsub('[[:punct:]|[:digit:]]', " ", tweets)
        
        
        
        #convert to token vectors
        corpus.tokens <- unlist(c(stri_split_fixed(stri_trans_tolower(blogs), " ", omit_empty = TRUE),
                           stri_split_fixed(stri_trans_tolower(news), " ", omit_empty = TRUE),
                           stri_split_fixed(stri_trans_tolower(tweets), " ", omit_empty = TRUE)))
        # 65 seconds 
        system.time(
                corp.freq <- as.data.frame(sort(table(corpus.tokens), decreasing = TRUE))
        )
        
        
}


#------------------------------------------------------------------------------
#Predict next word based on bi-gram probability in training corpus
#
#Inputs:
#
predict2gram <- function(corpus.tokens){
        
        # apply Laplace Smoothing to account for zeroes that aren't in the test
        # set:
        ## P(wi | wi-1) = (count(wi, wi-1) + 1) / (count(wi-1)+V)
        
        # P(w|"the") = [count("the {w}") + 1] / (count("the")+V)
        # 
        # FOR every gram='(the [[:alpha:]])' in corpus:
        ## probability(gram) = compute count(gram)/count('the') 
        #
        #sort this probability vector to get top 3 predicted matches!
        #
        #
        
        
}




