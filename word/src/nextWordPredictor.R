library(data.table)
library(stringi)

#filepath <- "~/Documents/R/Projects/typed-word-predictor/word/data/"

loadGrams <- function(){
        system.time({
                
        #unigramDT <- data.table(readRDS('word/data/unigramDT.rds'))
        bigramDT <- data.table(readRDS('data/bigramDT.rds'))
        trigramDT <- data.table(readRDS('data/trigramDT.rds'))
        
        #setkey(unigramDT, unigrams)
        setkey(bigramDT, bigrams)
        setkey(trigramDT, trigrams)
        })
}


processInput <- function(inputstr){
        
        #remove any hashtag words
        #remove  any apostrophes, then replace other punctuation marks and numbers with space
        inputstr <- gsub('[[:punct:]|[:digit:]]', "",
                         gsub('\'', '',
                              gsub('#[[:alpha:]|[:digit:]]+',"", tolower(inputstr))))
        
        # split the input on space characters
        stream <- stringi::stri_split_regex(inputstr, "\\s", omit_empty = TRUE)
        
        strlen <- length(stream[[1]])
        
        # extract last two tokens for bi-gram based prediction:
        ifelse(strlen<2,
               return(NULL),
               return(stream[[1]][(strlen-1):strlen])
               )
}



predict_trigram <- function(stream, bigramDT, trigramDT){
        
#         cat('stream[1] = ',stream[1])
#         cat('stream[2] = ',stream[2])

        #for every stream regex+word match in trigram frequency table:
        ##solve: P(word | stream1 stream2) = P(stream1 stream2 | word) * P(word)/P(stream1 & stream2)
        ##which translates to (count of stream+word)*count(word) / count(stream)
        ##without any smoothing
        
#         setkey(trigramDT, trigrams)
#         
#         streamDT <- trigramDT[grep(paste0('^',stream[1],'_',stream[2]), trigrams, value = TRUE), ][order(-freq)]
#         setkey(streamDT, freq, trigrams)
# 
#         potentials <- streamDT[,regmatches(trigrams,
#                                            regexpr("(?<=_)[A-Za-z]+$",trigrams, perl = TRUE))]
        
        
        #uses Laplace Smoothing to account for unseen input
        ###solve: P(word | stream1 stream2) = P(stream1 stream2 | word) * P(word)/P(stream1 & stream2)
        ## count of (stream1 stream2 word) /count of (stream1 stream2) )
        ##without any smoothing
        
        #bigramTypes <- bigramDT[,.N-stri_duplicated_any(bigrams)]
                
        bifreq <- bigramDT[.(paste0(stream[1],'_',stream[2])),freq] 
        tempDT <- trigramDT
        
        #apply Laplace Smoothing 
        if(is.na(bifreq)){
                predictions <- "NA"
                tempDT[,prob:=0]
                rm('tempDT')
                return(predictions)
        }
        else{
                tempDT <- tempDT[trigrams %like% paste0("^",stream[1],"_",stream[2])][,prob:=freq/bifreq][order(-prob)]
                predictions <- regmatches(tempDT[,head(trigrams,10)], 
                                          regexpr("(?<=_)[A-Za-z]+$",
                                          tempDT[,head(trigrams,10)], 
                                          perl = TRUE))
                tempDT[,prob:=0]
                rm('tempDT')
                return(predictions)
                
        }
#                tempDT <- tempDT[.(trigrams %like% paste0("^",stream[1],"_",stream[2])), 
#                                prob:=freq/bifreq][order(-prob)])
                
        
        
}








# processData <- function(filepath){
#         blogs <- stri_flatten(sample(readLines(paste0(filepath,"en_US.blogs.txt"), encoding='UTF-8'), 50))
#         news <- stri_flatten(sample(readLines(paste0(filepath,"en_US.news.txt"), encoding='UTF-8'), 50))
#         tweets <- stri_flatten(sample(readLines(paste0(filepath,"en_US.twitter.txt"), encoding = 'UTF-8'), 50))
#         
#         #try to preserve morphemes (can't, isn't, won't, i'm, by removing ')
#         
#         #remove punctuation and numbers
#         blogs <- gsub('[[:punct:]|[:digit:]]', " ", gsub('\'', '', blogs))
#         news <- gsub('[[:punct:]|[:digit:]]', " ", gsub('\'', '', news))
#         #also remove all hashtags from twitter corpus... 
#         tweets <- gsub('[[:punct:]|[:digit:]]', " ", 
#                        gsub('#[[:alpha:]|[:digit:]]+',"", 
#                             gsub('\'', '', tweets)))
#         
#         
#         
#         #convert to token vectors
# #         corpus.tokens <- stri_flatten(c(stri_split_fixed(stri_trans_tolower(blogs), " ", omit_empty = TRUE),
# #                            stri_split_fixed(stri_trans_tolower(news), " ", omit_empty = TRUE),
# #                            stri_split_fixed(stri_trans_tolower(tweets), " ", omit_empty = TRUE)))
#         corpus.tokens <- stri_flatten(c(stri_trans_tolower(blogs),
#                                         stri_trans_tolower(news),
#                                         stri_trans_tolower(tweets)))
#         # 65 seconds 
#         system.time(
#                 corp.freq <- as.data.frame(sort(table(corpus.tokens), decreasing = TRUE))
#         )
#         
#         
# }
# 
# 
# #------------------------------------------------------------------------------
# #Predict next word based on bi-gram probability in training corpus
# #
# #Inputs:
# ##input string 
# ##training corpus
# #
# #Outputs:
# ##top terms and their probabilities P(next term | input string)
# #-------------------------------------------------------------------------------
# predict2gram <- function(w, corpus.tokens){
#         
#         # apply Laplace Smoothing to account for zeroes that aren't in the test
#         # set:
#         ## P(wi | wi-1) = (count(wi, wi-1) + 1) / (count(wi-1)+V)
#         
#         # P(w|"the") = [count("the {w}") + 1] / (count("the")+V)
#         # 
#         # FOR every gram='(the [[:alpha:]])' in corpus:
#         ## probability(gram) = compute count(gram)/count('the') 
# #         ngram.df <- data.frame(ngram='temp', prob=0)
# #         
# #         system.time(
# #         lapply(stri_match(corpus.tokens, regex = "the [[:alpha:]]", mode = 'all'),
# #                function(X){
# #                        ngram.df <- rbind(ngram.df, 
# #                                          data.frame(ngram = X, 
# #                                                     prob = (stri_count_fixed(corpus.tokens, X)+1)/(stri_count_fixed(corpus.tokens, 'the')+stri_count_fixed(corpus.tokens, X))))
# #                                          })
# #         )
#         
#         
#         #sort this probability vector to get top 3 predicted matches!
#         
#        
#         
#         #II. Populate data table with n-gram frequencies
#         ngramFreq(1)
#         
# 
#         
#         
#         
# }
# 
# ngramFreq <- function(n){
#         #I. Create data table of n-gram X n-gram dimensions from whole corpus
#                
#         one.grams <- stri_unique(stri_split_fixed(corpus.tokens, " ",omit_empty=TRUE)[[1]])
#         
#         
#         #switch here for n-grams, later
#         
#         dt1 <- as.data.table(data.frame(matrix(0, 
#                                                nrow = length(one.grams), 
#                                                ncol = length(one.grams),
#                                                dimnames = list(one.grams,one.grams))))
#         dt1[,(colnames(dt1)):=lapply(.SD,as.integer), .SDcols=colnames(dt1)]
#         
#         dt1[,tokens_ := colnames(dt1)]
#         setkey(dt1, tokens_)
#         
#         
#         #II. Generate frequencies of ngrams
# #         dt1[, 
# #              lapply(.SD, function(x){
# #                     stri_count_fixed(s, paste0(x,' ',dt1[,tokens_][1]))
# #             }), 
# #             by=tokens_, 
# #             .SDcols=colnames(dt1)]
#         
#         
#         for (r in 1:length(dt1[,tokens_])){
#                 for (c in colnames(dt1)[1:length(colnames(dt1))-1]){
#                         #replace the search here with reference to a term freq. matrix
#                        set(dt1, i=r, j=c, value=stri_count_fixed(corpus.tokens, paste0(c,' ',dt1[r,'tokens_',with=FALSE])))
#                 }
#         }
#         
#         #III. Compute n-gram Probability, given input
#         input <- "test"
#         
#         #P(?w | "test") = P(all words, test)/P(test)
#         
#         P <- dt1[, input,with=FALSE]/stri_count_fixed(corpus.tokens, input)
#         
#         
#         
#         #prediction
#         dt1[P[,lapply(.SD,which.max), .SDcols=colnames(P)][[1]], 
#             'tokens_', 
#             with=FALSE]
# 
# 
#                 
#                         
#         
#         
# }


