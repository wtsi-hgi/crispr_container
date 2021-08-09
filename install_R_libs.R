# libs to install 

# install non-bioconductor packages:
to_install = c("sgRSEA","quadprog","sm","MESS","kinship2")
install.packages(to_install)

# devtools github install:
install.packages("devtools")
library(devtools)
install_github("francescojm/CRISPRcleanR")
install_github("jyyu/ScreenBEAM")

# install bioconductor packages:
to_install_bioconductor = c(
"ShortRead",
"seqinr",
"BiocGenerics",
"biomaRt",
"DESeq2",
"reshape2",
"DEoptim",
"tidyverse",
"caTools",
"BiocParallel",
"dplyr",
"ggplot2",
"reshape2",
"tidyr",
"DT",
"VennDiagram",
"stringr",
"glue",
"CB2",
"Rqc")

# Install BiocManager if not done already:
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos='http://cran.us.r-project.org')

BiocManager::install(to_install_bioconductor)
