##This is the QC procedures
##1: Missingness of SNPs and individuals
##2: Sex discrepancy
##3: Minor allele frequency (MAF)
##4: Hardy–Weinberg equilibrium (HWE)
##5: Heterozygosity
##6: Relatedness
##(X)7: Population stratification
# tasSumExp <- rTASSEL::getSumExpFromGenotypeTable(
#   tasObj = tasGenoDF
# )
# 
# tasSumExp

tasGenoPhenoFilt <- rTASSEL::filterGenotypeTableSites(
  siteRangeFilterType = "none",
  tasObj = tasGenoPheno,
  siteMinCount = 400,
  siteMinAlleleFreq = 0.02,
  siteMaxAlleleFreq = 1.0
)
tasGenoPhenoFilt
tasGenoPheno

# Create a kinship matrix object
tasKin <- rTASSEL::kinshipMatrix(tasObj = tasGenoPheno)
tasKinRMat <- rTASSEL::kinshipToRMatrix(tasKin)
tasKinRMat[1:5, 1:5]

# Calculate a distance matrix
tasDist <- rTASSEL::distanceMatrix(tasObj = tasGenoPheno)
tasDistRMat <- rTASSEL::distanceToRMatrix(tasDist)
tasDistRMat[1:5, 1:5]

# Association test began
# formula is 'list(BW8, GLUCOM) ~ location + SEX'

# 1. GLM
tasGLM <- rTASSEL::assocModelFitter(
  tasObj = tasGenoPheno,             # <- our prior TASSEL object
  formula = list(BW8, GLUCOM) ~ location + SEX,  # <- only EarHT and dpoll are ran
  fitMarkers = TRUE,                 # <- set this to TRUE for GLM
  kinship = NULL,
  fastAssociation = FALSE
)
# Return GLM output
tasGLM

#2. 
