install.packages("textmineR")
install.packages("readPDF")
install.packages("tm")
install.packages("pdftools")


##create a .txt dataset from pdf file
load("pdftools")
text<-"Cabo_verde_INDC_.pdf"
text<-pdftools::pdf_text(text) #extract text from pdf
length(text)  ##check length of file
text_dt<-write.table(text,file=paste("Cabo_verde_INDC",sep="."), 
 quote = FALSE, row.names = FALSE, col.names = FALSE, eol = " " )
