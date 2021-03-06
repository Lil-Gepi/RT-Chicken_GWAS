options(java.parameters = c("-Xmx200g", "-Xms2g"))
library(rJava)
library(rTASSEL)
startLogger(fullPath = NULL, fileName = NULL)

##------------------------------------------------------------------------------
## Read in the phenotype data

# Read the original csv table
pheno_csv <-
  read.csv("/home/yiwen/nas/AIL_phenotypes20190827.csv", header = T)

# Only keep the generation 2 data
pheno_gen2 <- pheno_csv[pheno_csv$GENERATION == 2, ]


# Remove the empty columns
pheno_gen2_notnull <-
  Filter(function(x)
    ! all(is.na(x) ||
            is.null(x) || x == ""), pheno_gen2)
#rm(pheno_gen2)

# Now we decide which trait are we interested in
pheno_gen2_picked <-
  pheno_gen2_notnull[c("ID", "BW8", "GLUCOM", "SEX")]
row.names(pheno_gen2_picked) <-
  pheno_gen2_picked$ID
#rm(pheno_gen2_notnull)

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

## Very important part is following, we need to remove the samples without any data
## of both traits.
pheno_ordered[pheno_ordered == ""] <- NA
pheno_noNA <-
  pheno_ordered[!(is.na(pheno_ordered$BW8) &
                    is.na(pheno_ordered$GLUCOM)),]
sum(is.na(pheno_ordered$BW8) & is.na(pheno_ordered$GLUCOM))
sum(is.na(pheno_noNA$BW8) & is.na(pheno_noNA$GLUCOM))
passed_sample <- as.array(as.numeric(row.names(pheno_noNA)))
write.table(
  x = passed_sample,
  row.names = F,
  col.names = F,
  sep = "\n",
  file = "/home/yiwen/RT-Chicken_GWAS/gen2_sample_id_passed.txt"
)
# To tell rTassel what to expect, he first header should be "Taxon", with rest of them as is.
phenoDF <- pheno_noNA
colnames(phenoDF)[1] <- "Taxon"

# Following will be steps correct the type pf the data we have.

# 1. the GLUCOM data is actually character type and the decimal point is comma in Swedish way
#    we would like to change that to a normal numeric column.
phenoDF$GLUCOM <- as.character(phenoDF$GLUCOM)
scan(text = phenoDF$GLUCOM,
     dec = ",",
     sep = ".")
phenoDF$GLUCOM <- as.numeric(phenoDF$GLUCOM)

# 2. tomake sure the other columns are also in the right type of our desire.
phenoDF$SEX <- as.factor(phenoDF$SEX)
phenoDF$Taxon <- as.character(phenoDF$Taxon)

# 3. mic check mic check
typeof(phenoDF$Taxon)
typeof(phenoDF$BW8)
typeof(phenoDF$GLUCOM)
typeof(phenoDF$SEX)
summary(phenoDF)

rm(pheno_csv, pheno_gen2, pheno_gen2_notnull, pheno_gen2_picked, sample_w_geno, passed_sample, pheno_noNA, pheno_ordered)
##[unnecessary]phenoDF <- phenoDF[!is.na(phenoDF$BW8), ]; phenoDF <- phenoDF[!is.na(phenoDF$GLUCOM), ]

# Finally to read the phenotable into rTassel, execpt for the data itself, we also would like
# to specify what kind of data each column is, so we'll need a vector to pass to attibuteTypes to do so.
phenoAttribute <- c("data", "data", "factor")

tasPhenoDF <-
  rTASSEL::readPhenotypeFromDataFrame(phenotypeDF = phenoDF,
                                      taxaID = "Taxon",
                                      attributeTypes = phenoAttribute)
# As we can see, this tasPhenoDF is in a strange format, yet we want to combine the genoDF with phenoDF now.
tasPhenoDF

##------------------------------------------------------------------------------
## Read in the genotype data
tasGenoDF <-
  rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/nas/chr_all_gen2.vcf", sortPositions = T)
tasGenoDF

##------------------------------------------------------------------------------

# To combine, I chose to read from the two objects we have created, while the specification
# used in creating tasPhenoDF needs to be passed to TASSEL again.
tasGenoPheno <- rTASSEL::readGenotypePhenotype(
  genoPathOrObj = tasGenoDF,
  phenoPathDFOrObj = tasPhenoDF,
  taxaID = "Taxon",
  attributeTypes = phenoAttribute
)
# Let's take a look at this boiiiiii!
tasGenoPheno
#save(tasGenoPheno, file = "/home/yiwen/RT-Chicken_GWAS/GenoPheno.RData")


tasGenoPhenoFilt <- rTASSEL::filterGenotypeTableSites(
  siteRangeFilterType = "none",
  tasObj = tasGenoPheno,
  siteMinCount = 400,
  siteMinAlleleFreq = 0.02,
  siteMaxAlleleFreq = 1.0
)

# Create a kinship matrix object
tasKin <- rTASSEL::kinshipMatrix(tasObj = tasGenoPhenoFilt)

# 2. MLM
tasMLM <- rTASSEL::assocModelFitter(
  tasObj = tasGenoPhenoFilt,             
  formula = . ~ .,               
  fitMarkers = TRUE, 
  kinship = tasKin,                  
  fastAssociation = FALSE
)
# Return MLM output
tasMLM
save(tasMLM, file = '/home/yiwen/RT-Chicken_GWAS/tasMLM.RData')
