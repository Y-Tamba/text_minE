install.packages("textmineR")
install.packages("readPDF")
install.packages("tm")
install.packages("pdftools")
install.packages("dplyr")
library("dplyr")
library("rvest")
library("xml2")
library('RSelenium')

##create a .txt dataset from pdf file using cabo verde to illustrate
text<-("Cabo_Verde_INDC_.pdf")


##css selector individual page 
text_input<-rvest::read_html("https://www.geeksforgeeks.org/css-links/")
script<-xml_attrs(xml_child(xml_child(text_input, 1), 19))[["href"]]
text_script2<-text_input %>%
  xml_attrs(xml_child(xml_child(text_input, 1), 19))[["href"]] %>% 
  html_text()

text_script3<-text_input %>%
  xml_attrs(xml_child(xml_child(xml_child(text_input2, 2), 1), 1))[["src"]] %>% 
  html_text()


##css selector all pages 
text_input2<-rvest::read_html("https://www4.unfccc.int/sites/NDCStaging/Pages/All.aspx")
table<-html_nodes(text_input2) 

nodes<-text_input2 %>% 
       html_node(id="divctl00_m_g_e7b2d30c_d41f_4a0c_9bd4_a7d111a5d6cb_ctl00")

list<-for(i in nodes){
  r <- list(nodes%>% html_nodes(" ")%>%html_text())
}     

nodes<-text_input2 %>% 
  html_structure() 
 
page <- read_html('https://finance.yahoo.com/quote/AAPL/financials?p=AAPL')
nodes <- page %>%html_nodes(".fi-row")
df = NULL

for(i in nodes){
  r <- list(i %>%html_nodes("[title],[data-test='fin-col']")%>%html_text())
  df <- rbind(df,as.data.frame(matrix(r[[1]], ncol = length(r[[1]]), byrow = TRUE), stringsAsFactors = FALSE))
}


## selenium

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445L, browserName = "chrome")

remDr$open()
url<-remDr$navigate("https://www4.unfccc.int/sites/NDCStaging/Pages/All.aspx")
webpage <- read_html(remDr$getPageSource()[[1]])

css_path2<-"html > body > form > div:nth-of-type(7) > div:nth-of-type(2) > div:nth-of-type(3) > div:nth-of-type(1) > div:nth-of-type(2) > div:nth-of-type(1) > table:nth-of-type(2) > tbody > tr:nth-of-type(1) > td > table > tbody > tr > td > div > div > div > div > div:nth-of-type(3) > div:nth-of-type(1) > div:nth-of-type(2) > div > section:nth-of-type(1) > div > div > div > div:nth-of-type(3) > div:nth-of-type(2) > a"

section<-remDr$findElement(using = "class",value= "col-sm-5")
 
nodes<-webpage %>% 
     html_node(class="col-sm-5") %>%  
  html_attr(name = "href")
   
script<-html_node(webpage, xpath= "//table[contains(@href")#//class[contains(@href,',pdf')]")

target_script<-html_node(webpage, xpath= "//form/*[@id='s4-workspace']") #/a[contains@href]') #,".pdf"]')

path_1<-html_node(webpage,xpath= "//div[contains(@title, 'https://www4.unfccc.int/sites/ndcstaging/PublishedDocuments/Afghanistan%20First/INDC_AFG_20150927_FINAL.pdf')]")


'https://www4.unfccc.int/sites/ndcstaging/PublishedDocuments/Afghanistan%20First ...
text_script<-text_input2 %>%
  html_node (%>% ) %>%  
  html_text ()

trypaths<-
  
 x_attribute_path<-xml_attrs(xml_child(xml_child(xml_child(xml_child(xml_child(xml_child(xml_child
                  (xml_child(table[[1]], 29), 1), 1), 2), 2), 1), 3), 1))#["href"]

text_script2<-text_input2 %>%
 html_nodes(xpath=x_attribute_path) %>% 
  html_text()

text_script3<-text_input2 %>%
  xml_attrs(xml_child(xml_child(xml_child(text_input2, 2), 1), 1))[["src"]] %>% 
  html_text()
  


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
