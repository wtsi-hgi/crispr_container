# libs to install 
to_install = c(
"ShortRead",
"seqinr",
"sgRSEA",
"BiocGenerics",
"biomaRt",
"MESS",
"DESeq2",
"reshape2",
"DEoptim",
"tidyverse",
"caTools",
"BiocParallel",
"ScreenBEAM",
"sm",
"dplyr",
"ggplot2",
"reshape2",
"tidyr",
"DT",
"VennDiagram",
"stringr",
"glue",
"CB2",
"Rqc",
"CRISPRcleanR")

# Install BiocManager if not done already:
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos='http://cran.us.r-project.org')

BiocManager::install(to_install)
