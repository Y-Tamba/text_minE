install.packages("textmineR")
install.packages("readPDF")
install.packages("tm")
install.packages("pdftools")


##create a .txt dataset from pdf file using cabo verde to illustrate
load("pdftools")
text<-"Cabo_verde_INDC_.pdf"
text<-pdftools::pdf_text(text) #extract text from pdf
length(text)  ##check length of file
text_dt<-write.table(text,file=paste("Cabo_verde_INDC",sep="."), 
 quote = FALSE, row.names = FALSE, col.names = FALSE, eol = " " )

##create a dtm matrix of all documents. Start with .csv input containing links to all documents
docs_input<-(read.csv("NDCs_INDCs_Africa.csv"))
docs_col<-docs_input[,4]
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
