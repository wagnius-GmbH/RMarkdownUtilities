###################################################################
#' Automatically creates a table of contents for a .Rmd file
#' @name create_Rmd_from_word
#' @description
#' Scans documents for headings (#) and creates a table of contents (hyper linked). The returned string can directly be written as .Rmd file.
#' All code section will be excluded for the (#) search.
#' @details
#' As the function argument pass a R markdown .Rmd file string which can be read via \code{readLines("fileName.Rmd")}.
#' @param doc word document string
#' @param toc boolean to enable table of contents (toc)
#' @return .Rmd file string
#' @export

create_Rmd_from_word <- function(doc, toc = TRUE) {
  c_table_of_content <- list()
  c_md <- ""
  first_paragraph <- TRUE
  cnt <- 1
  for (ii in 1:nrow(doc)) {
    if(is.na(doc$style_name[ii])){
      if(first_paragraph)  {
        c_md[ii] <- doc$text[ii]|>paste0("  \\")
        first_paragraph <- FALSE
      }
      else {
        c_md[ii] <- doc$text[ii]|>paste0("  \\")
      }
    }
    else if (doc$style_name[ii] == "Title"){
      first_paragraph <- T
      c_md[ii] <- paste0("---\ntitle: ","\"",doc$text[ii],
                         "\"\nauthor: \"",doc$doc_properties$data["creator","value"],
                         "\"\ndate: \"",Sys.Date(),"\"\noutput:\n    html_document: default\n    word_document: default\n    pdocument: default\n---")
    }
    else if (doc$style_name[ii] == "heading 1"){
      c_md[ii] <- paste0("\n# ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      first_paragraph <- T
      c_table_of_content[[cnt]] <- paste0("\n","* ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
    else if (doc$style_name[ii] == "heading 2"){
      first_paragraph <- T
      c_md[ii] <- paste0("\n## ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      c_table_of_content[[cnt]] <- paste0("\n","    + ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
    else if (doc$style_name[ii] == "heading 3"){
      first_paragraph <- T
      c_md[ii] <- paste0("\n### ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      c_table_of_content[[cnt]] <- paste0("\n","        + ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
    else if (doc$style_name[ii] == "heading 4"){
      first_paragraph <- T
      c_md[ii] <- paste0("\n#### ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      c_table_of_content[[cnt]] <- paste0("\n","            + ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
    else if (doc$style_name[ii] == "heading 5"){
      first_paragraph <- T
      c_md[ii] <- paste0("\n##### ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      c_table_of_content[[cnt]] <- paste0("\n","                + ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
    else if (doc$style_name[ii] == "heading 6"){
      first_paragraph <- T
      c_md[ii] <- paste0("\n###### ",doc$text[ii],"<a name=\"",doc$text[ii],"\"></a>")
      c_table_of_content[[cnt]] <- paste0("\n","                    + ","[",doc$text[ii],"]","(#",doc$text[ii],")")
      cnt <- cnt + 1
    }
  }
  if(toc){
    c_md <- c(c_md[1],
              "# Tabel of Content",
              c_table_of_content|>unlist()|>paste0(collapse = "  \\"),
              c_md[2:length(c_md)])
  }
  return(c_md)
}
