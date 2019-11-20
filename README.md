# resume
My resume built in R with  pagedown::html_resume.

The main files are:

- `update_resume.R` : R script that renders the Rmarkdown document twice, once for HTML version and once for PDF version.  This ensures both versions are always the same.
- `resume.Rmd`: Source template for both the PDF and HTML versions, based on the YAML Paramater doctype
- `index.html`: The final output of the template when the parameter doctype is set to HTML. 
- `mleary_resume.pdf`: Result for single page PDF file.  Note, this version has a different CSS styling sheet and is in black and white for more consistent printing.
- `resume_data.xlsx`: An excel file with my work and skills data.
- `css/`: Directory containing the custom CSS files used to tweak the default 'resume' format from pagedown.

Shout out to Nick Strayer, whose code was the basis for my format.  I heavily borrowed from his code and approach.  See the original here http://nickstrayer.me/cv/
