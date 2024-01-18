source("R/RMarkdown_from_word_summary.R")

word_file <- officer::read_docx("files/input/test.docx")
df_word <- officer::docx_summary(word_file)
df_word|>
  create_Rmd_from_word()|>
  writeLines("files/word_converted_to_Markdown.Rmd")

