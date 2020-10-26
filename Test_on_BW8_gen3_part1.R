options(java.parameters = c("-Xmx200g", "-Xms2g"))
library(rJava)
library(rTASSEL)
startLogger(fullPath = NULL, fileName = NULL)

##------------------------------------------------------------------------------
## Read in the phenotype data
bash_command <-"bcftools query -l /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006115.5_Chr28_K10nGen19_SCOREHWE_no294BadSm.vcf.gz | grep 03$ > /home/yiwen/RT-Chicken_GWAS/gen3_sample_id.txt"
system(bash_command)
rm(bash_command)
# Read the original csv table
pheno_csv <-
  read.csv("/home/yiwen/nas/AIL_phenotypes20190827.csv", header = T)

# Only keep the generation 3 data
pheno_gen3 <- pheno_csv[pheno_csv$GENERATION == 3, ]


# Remove the empty columns
pheno_gen3_notnull <-
  Filter(function(x)
    ! all(is.na(x) ||
            is.null(x) || x == ""), pheno_gen3)
rm(pheno_gen3)

# Now we decide which trait are we interested in
pheno_gen3_picked <-
  pheno_gen3_notnull[c("ID", "BW8", "SEX")]
row.names(pheno_gen3_picked) <-
  pheno_gen3_picked$ID
rm(pheno_gen3_notnull)

# Next we want to sort our pheno table by the same order of the sample id used in the geno vcf file
# 1. we read the sample ids in vcf file with order.
sample_w_geno <-
  read.csv(
    file = "/home/yiwen/RT-Chicken_GWAS/gen3_sample_id.txt",
    sep = "\n",
    header = F,
    col.names = "ID",
    stringsAsFactors = F
  )
row.names(sample_w_geno) <- sample_w_geno$ID
# 2. we order the pheno table accordingly
pheno_ordered <- pheno_gen3_picked[row.names(sample_w_geno), ]

## Very important part is below, we need to remove the samples without any data
## of both traits.
pheno_ordered[pheno_ordered == ""] <- NA
pheno_noNA <-
  pheno_ordered[!is.na(pheno_ordered$BW8),]
# sum(is.na(pheno_ordered$BW8) & is.na(pheno_ordered$GLUCOM))
# sum(is.na(pheno_noNA$BW8) & is.na(pheno_noNA$GLUCOM))
passed_sample <- as.array(as.numeric(row.names(pheno_noNA)))
write.table(
  x = passed_sample,
  row.names = F,
  col.names = F,
  sep = "\n",
  file = "/home/yiwen/RT-Chicken_GWAS/gen3_sample_id_passed.txt"
)
# To tell rTassel what to expect, he first header should be "Taxon", with rest of them as is.
phenoDF <- pheno_noNA
colnames(phenoDF)[1] <- "Taxon"

# Following will be steps correct the type pf the data we have.

# 2. tomake sure the other columns are also in the right type of our desire.
phenoDF$SEX <- as.factor(phenoDF$SEX)
phenoDF$Taxon <- as.character(phenoDF$Taxon)

# 3. mic check mic check
typeof(phenoDF$Taxon)
typeof(phenoDF$BW8)
typeof(phenoDF$SEX)
summary(phenoDF)

rm(pheno_csv, pheno_gen3, pheno_gen3_notnull, pheno_gen3_picked, sample_w_geno, passed_sample, pheno_noNA, pheno_ordered)

# Finally to read the phenotable into rTassel, execpt for the data itself, we also would like
# to specify what kind of data each column is, so we'll need a vector to pass to attibuteTypes to do so.
phenoAttribute <- c("data", "factor")

tasPhenoDF <-
  rTASSEL::readPhenotypeFromDataFrame(phenotypeDF = phenoDF,
                                      taxaID = "Taxon",
                                      attributeTypes = phenoAttribute)
# As we can see, this tasPhenoDF is in a strange format, yet we want to combine the genoDF with phenoDF now.
tasPhenoDF
