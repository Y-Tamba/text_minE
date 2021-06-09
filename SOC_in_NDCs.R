install.packages("textmineR")
install.packages("readPDF")
install.packages("tm")
install.packages("pdftools")
install.packages("dplyr")
library("dplyr")
library("rvest")
library(V8)

##create a .txt dataset from pdf file using cabo verde to illustrate
text<-("Cabo_Verde_INDC_.pdf")
text_input<-rvest::read_html("https://www4.unfccc.int/sites/ndcstaging/PublishedDocuments/Cabo%20Verde%20First/Cabo_Verde_INDC_.pdf")
text_input2<-rvest::read_html("https://www4.unfccc.int/sites/NDCStaging/Pages/All.aspx")

text_script<-text_input2 %>%
  html_node ("script type=") %>% 
  html_text ()

text_script2<-text_input2 %>%
  #html_nodes(".href") %>% 
  html_nodes(xpath='//div/a[contains(@href,"https")]') %>%
             #"https://www4.unfccc.int/sites/ndcstaging/PublishedDocuments/Cabo%20Verde%20First/Cabo%20Verde_NDC%20Update%202021.pdf") %>%
  html_text()

  xpath='//td/a[contains(@href,"javascript")]'


text<-pdftools::pdf_text(text_script2) #extract text from pdf
length(text)  ##check length of file
text_dt<-write.table(text,file=paste("Cabo_verde_INDC",sep="."), 
 quote = FALSE, row.names = FALSE, col.names = FALSE, eol = " " )

caboVerde_NDC<-textmineR::CreateDtm(doc_vec=text, 
                              doc_names = NULL,
                              ngram_window = c(1,1), # minimum and maximum n-gram length
                              stopword_vec = c(stopwords::stopwords("en"), # stopwords from tm
                                               stopwords::stopwords(source = "smart")), # this is the default value
                              lower = TRUE, # lowercase - this is the default value
                              remove_punctuation = TRUE, # punctuation - this is the default
                              remove_numbers = TRUE, # numbers - this is the default
                              verbose = TRUE # Turn off status bar for this demo
) 

caboVerde_NDC@Dimnames[[2]]
wordcount<-textmineR::TermDocFreq(caboVerde_NDC)

##create a dtm matrix of all documents. Start with .csv input containing links to all documents
docs_input<-(read.csv("NDCs_INDCs_Africa.csv"))
docs_col<-docs_input[,4]
text_dt<-write.table(text,file=paste("Cabo_verde_INDC",sep="."), 
                     quote = FALSE, row.names = FALSE, col.names = FALSE, eol = " " )
text_dt<-textmineR::CreateDtm(doc_vec=docs_col,
                              doc_names = NULL,
                     ngram_window = c(1,1), # minimum and maximum n-gram length
                     stopword_vec = c(stopwords::stopwords("en"), # stopwords from tm
                                      stopwords::stopwords(source = "smart")), # this is the default value
                     lower = TRUE, # lowercase - this is the default value
                     remove_punctuation = TRUE, # punctuation - this is the default
                     remove_numbers = TRUE, # numbers - this is the default
                     verbose = TRUE # Turn off status bar for this demo
                     ) 


CreateDtm(doc_vec = movie_review$review, # character vector of documents
          doc_names = movie_review$id, # document names, optional
          ngram_window = c(1, 2), # minimum and maximum n-gram length
          stopword_vec = c(stopwords::stopwords("en"), # stopwords from tm
                           stopwords::stopwords(source = "smart")), # this is the default value
          lower = TRUE, # lowercase - this is the default value
          remove_punctuation = TRUE, # punctuation - this is the default
          remove_numbers = TRUE, # numbers - this is the default
          verbose = FALSE, # Turn off status bar for this demo
          cpus = 2) # by default, this will be the max number of cpus available
