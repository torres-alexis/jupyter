#!/usr/bin/env Rscript

# Set CRAN mirror
r <- getOption("repos")
r["CRAN"] <- "https://cloud.r-project.org"
options(repos = r)

# Install BiocManager if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", dependencies = TRUE)

# Install Bioconductor packages
BiocManager::install(c(
    "tximport",
    "DESeq2",
    "org.Mm.eg.db",
    "STRINGdb",
    "PANTHER.db",
    "ComplexHeatmap",
    "EnhancedVolcano",
    "clusterProfiler",
    "goseq",
    "fgsea",
    "enrichplot"
), update = FALSE, ask = FALSE)

# Install tidyheatmap from CRAN
install.packages("tidyheatmap", dependencies = TRUE)