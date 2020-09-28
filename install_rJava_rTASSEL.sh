#!/bin/sh
apt update -y
apt install -y openjdk-8-jdk openjdk-8-jre
R CMD javareconf JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
Rscript -e 'install.packages("rJava");library(rJava)'
Rscript -e 'if (!require("devtools")) install.packages("devtools")'
Rscript -e 'devtools::install_bitbucket( repo = "bucklerlab/rTASSEL", ref = "master", build_vignettes = FALSE)'



