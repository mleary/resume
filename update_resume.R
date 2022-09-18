# author: matt leary
# date: November 19, 2019
# intent: update the resume html and pdf file in one script

rmarkdown::render(input = "resume.Rmd",
                  output_file = "index.html",
                  output_options = list(
                    css = c('css/custom_resume.css', 'css/styles_html.css', 'resume'),
                    self_contained = TRUE
                  ),
                  params = list(
                    doctype = "HTML"
                  )
            )

rmarkdown::render(input = "resume.Rmd",
                  output_file = "mleary_resume_print_to_pdf.html",
                  output_options = list(
                    css = c('css/custom_resume.css', 'css/styles_pdf.css', 'resume')
                    ),
                  params = list(
                    doctype = "PDF"
                  )
)

