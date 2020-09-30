options(java.parameters = c("-Xmx200g", "-Xms2g"))
library(rJava)
library(rTASSEL)
startLogger(fullPath = NULL, fileName = NULL)
##------------------------------------------------------------------------------
## Read in the genotype data
tasGenoDF <-
  rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/RT-Chicken_GWAS/chr_all_gen2.vcf")
tasGenoDF

##------------------------------------------------------------------------------
## Read in the phenotype data

# Read the original csv table
pheno_csv <-
  read.csv("/home/yiwen/nas/AIL_phenotypes20190827.csv", header = T)

# Only keep the generation 2 data
pheno_gen2 <- pheno_csv[pheno_csv$GENERATION == 2, ]
rm(pheno_csv)

# Remove the empty columns
pheno_gen2_notnull <-
  Filter(function(x)
    ! all(is.na(x) ||
            is.null(x) || x == ""), pheno_gen2)
rm(pheno_gen2)

# Now we decide which trait are we interested in
pheno_gen2_picked <-
  pheno_gen2_notnull[c("ID", "BW8", "GLUCOM", "SEX")]
row.names(pheno_gen2_picked) <-
  pheno_gen2_picked$ID
rm(pheno_gen2_notnull)

# Next we want to sort our pheno table by the same order of the sample id used in the geno vcf file
# 1. we read the sample ids in vcf file with order.
sample_w_geno <-
  read.csv(
    file = "/home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt",
    sep = "\n",
    header = F,
    col.names = "ID",
    stringsAsFactors = F
  )
row.names(sample_w_geno) <- sample_w_geno$ID
# 2. we order the pheno table accordingly
pheno_ordered <- pheno_gen2_picked[row.names(sample_w_geno), ]

# To tell rTassel what to expect, he first header should be "Taxon", with rest of them as is.
phenoDF <- pheno_ordered
colnames(phenoDF)[1] <- "Taxon"

# Following will be steps correct the type pf the data we have.
# 1. we would prefer to have NAs instead of empty blocks in our pheno table.
phenoDF[phenoDF == ""] <- NA

# 2. the GLUCOM data is actually character type and the decimal point is comma in Swedish way
#    we would like to change that to a normal numeric column.
phenoDF$GLUCOM <- as.character(phenoDF$GLUCOM)
scan(text = phenoDF$GLUCOM,
     dec = ",",
     sep = ".")
phenoDF$GLUCOM <- as.numeric(phenoDF$GLUCOM)

# 3. tomake sure the other columns are also in the right type of our desire.
phenoDF$SEX <- as.factor(phenoDF$SEX)
phenoDF$Taxon <- as.character(phenoDF$Taxon)

# 4. mic check mic check
typeof(phenoDF$Taxon)
typeof(phenoDF$BW8)
typeof(phenoDF$GLUCOM)
typeof(phenoDF$SEX)
summary(phenoDF)

##[unnecessary]phenoDF <- phenoDF[!is.na(phenoDF$BW8), ]; phenoDF <- phenoDF[!is.na(phenoDF$GLUCOM), ]

# Finally to read the phenotable into rTassel, execpt for the data itself, we also would like
# to specify what kind of data each column is, so we'll need a vector to pass to attibuteTypes to do so.
phenoAttribute <- c("data", "data", "factor")

tasPhenoDF <- rTASSEL::readPhenotypeFromDataFrame(phenotypeDF = phenoDF,
                                                  taxaID = "Taxon",
                                                  attributeTypes = phenoAttribute)
# As we can see, this tasPhenoDF is in a strange format, yet we want to combine the genoDF with phenoDF now.
tasPhenoDF

# To combine, I chose to read from the two objects we have created, while the specification
# used in creating tasPhenoDF needs to be passed to TASSEL again.
tasGenoPheno <- rTASSEL::readGenotypePhenotype(
  genoPathOrObj = tasGenoDF,
  phenoPathDFOrObj = tasPhenoDF,
  taxaID = "Taxon",
  attributeTypes = NULL
)
# Let's take a look at this boiiiiii!
tasGenoPheno
save(tasGenoPheno, file = "/home/yiwen/RT-Chicken_GWAS/GenoPheno.RData")