# RMarkdownUtilities
## Create a Markdown file from word files (.docx) 

-   Including the structure of the file (Heading and Title)

You need to install the officer package to read word files.

```
install.packages("officer")
```
Now you can use the following code to convert word files to RMarkdown files
```
source("R/RMarkdown_from_word_summary.R")

word_file <- officer::read_docx("files/input/test.docx")
df_word <- officer::docx_summary(word_file)
df_word|>
  create_Rmd_from_word()|>
  writeLines("files/word_converted_to_Markdown.Rmd")
```
As soon as you have converted you can knit the .Rmd files to html or word or PDF (PDF needs Latex (Miktex on Windows))

## Create automatically table of contents for Markdown files

-   Add automatically heading numbers
-   Correct automatically heading structure 
-   Change heading structure to start with first heading 
-   Define the title manually, instead of table of contents you can use "Inhaltsverzeichnis"
