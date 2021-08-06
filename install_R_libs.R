# libs to install 
to_install = c(,


               )

# Install BiocManager if not done already:
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos='http://cran.us.r-project.org')

BiocManager::install(to_install)
