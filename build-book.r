library(plyr)
l(decumar)
l(ggplot)

# Need to clean out include directory

chapters <- c("introduction", "layers", "mastery", "position", "polishing", "qplot", "scales", "grid", "specifications", "toolbox", "translating",  "data", "duplication", "book-springer")

tex <- paste(chapters, ".tex", sep="")
r <-   file.path("public", paste(chapters, ".r", sep=""))
pdf <- paste(chapters, ".pdf", sep="")

cache_clear()
l_ply(tex, function(path) {
  cat(path, "\n")
  overwrite_file(path)
})
m_ply(cbind(input = tex, output = r), function(input, output) {
  cat(input, "\n")
  output_code(input, output)
})

builders <- c("pdflatex", "bibtex", "pdflatex", "pdflatex")
build_cmds <- paste(builders, rep(tex, each = length(builders)), "> /dev/null")

l_ply(build_cmds, function(cmd) {
  message(cmd)
  system(cmd)
})

l_ply(paste("cp", pdf, "public"), system)
system("mv public/book-mine.pdf public/ggplot2-book.pdf")


cat("Remember to:
  * Change date on webpage
  * Update changelog
")

# git log --date=short --abbrev-commit  --stat