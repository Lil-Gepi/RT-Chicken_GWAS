##This is the QC procedures
##1: Missingness of SNPs and individuals
##2: Sex discrepancy
##3: Minor allele frequency (MAF)
##4: Hardy–Weinberg equilibrium (HWE)
##5: Heterozygosity
##6: Relatedness
##(X)7: Population stratification
options(java.parameters = c("-Xmx30g", "-Xms2g"))
library(rJava)
library(rTASSEL)
startLogger(fullPath = NULL, fileName = NULL)
##  read in the genotype data

tasGenoDF <- rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/nas/all_gen2.vcf.gz")
tasGenoDF <- rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006115.5_Chr28_K10nGen19_SCOREHWE_no294BadSm.vcf.gz")
tasGenoDF

# Analyze the phenotype data
pheno_csv <- read.csv("/home/yiwen/nas/AIL_phenotypes20190827.csv",header = T)

#generations <- unique(pheno_csv$GENERATION)
#genrations_samplesize <- data.frame()
# for (i in 1:length(generations)) {
#   genrations_samplesize[i,1] <- generations[i]
#   genrations_samplesize[i,2] <- nrow(pheno_csv[pheno_csv$GENERATION == generations[i],])
# }
#so generation 15 is the biggest dataset

pheno_gen2 <-pheno_csv[pheno_csv$GENERATION==2,] ; rm(pheno_csv)
# remove the empty columns of the pheno data
pheno_gen2_notnull <- Filter(function(x)!all(is.na(x) || is.null(x) || x == ""), pheno_gen2); rm(pheno_gen2)
pheno_gen2_picked <- pheno_gen2_notnull[c("ID","BW8","GLUCOM","SEX")] ; row.names(pheno_gen2_picked) <- pheno_gen2_picked$ID

sample_w_geno <- read.csv(file = "/home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt",sep = "\n", header = F, col.names = "ID", stringsAsFactors = F); row.names(sample_w_geno) <- sample_w_geno$ID
pheno_ordered <- pheno_gen2_picked[row.names(sample_w_geno),]
#checking how many of the samples don't have record in the traits
sum(sapply(pheno_ordered$GLUCOM, function(x) is.na(x) || is.null(x) || x == ""))
sum(sapply(pheno_ordered$BW8, function(x) is.na(x) || is.null(x) || x == ""))
#If it's okay we can load the data into rTASSEL as following
#phenoDF_tuto is an exampke from the tutorial, the phenoDF is the real one we gonna use
phenoPath_tuto  <- system.file("extdata", "mdp_traits.txt", package = "rTASSEL")
phenoDF_tuto <- read.table(phenoPath_tuto, header = TRUE) ; rm(phenoPath_tuto)
colnames(phenoDF_tuto)[1] <- "Taxon"
View(phenoDF_tuto)
#so the first header should be "Taxon", with rest of them as is.
phenoDF <- pheno_ordered; colnames(phenoDF)[1] <- "Taxon"
phenoDF[phenoDF==""]<-NA
# However the GLUCOM data is actually characters and the decimal point is comma in Swedish way
# We would like to change that to a normal numeric column.
phenoDF$GLUCOM <- as.character(phenoDF$GLUCOM)
scan(text=phenoDF$GLUCOM, dec=",", sep=".")
phenoDF$GLUCOM <- as.numeric(phenoDF$GLUCOM)
phenoDF$SEX <- as.factor(phenoDF$SEX)
phenoDF$Taxon <- as.character(phenoDF$Taxon)
typeof(phenoDF$Taxon)
typeof(phenoDF$BW8)
typeof(phenoDF$GLUCOM)
typeof(phenoDF$SEX)
summary(phenoDF)
####phenoDF <- phenoDF[!is.na(phenoDF$BW8), ]; phenoDF <- phenoDF[!is.na(phenoDF$GLUCOM), ]
#execpt for the data itself, we also would like to specify what kind of data each column is,
#so we'll need a vector to pass to attibuteTypes to do so.
phenoAttribute <- c( "data", "data", "factor")

tasPhenoDF <- rTASSEL::readPhenotypeFromDataFrame(
  phenotypeDF = phenoDF,
  taxaID = "Taxon",
  attributeTypes = phenoAttribute
)

# tasPhenoDF_tuto <- rTASSEL::readPhenotypeFromDataFrame(
#   phenotypeDF = phenoDF_tuto,
#   taxaID = "Taxon",
#   attributeTypes = NULL
# )
# rm(tasPhenoDF_tuto)
# Inspect new object
tasPhenoDF

