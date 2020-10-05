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

tasGenoPhenoFilt <- rTASSEL::filterGenotypeTableTaxa(
  tasObj = tasGenoPhenoFilt,
  minNotMissing = 0.95
)
tasGenoPhenoFilt
tasGenoPheno

# Create a kinship matrix object
tasKin <- rTASSEL::kinshipMatrix(tasObj = tasGenoPhenoFilt)
tasKinRMat <- rTASSEL::kinshipToRMatrix(tasKin)
tasKinRMat[1:5, 1:5]

# Calculate a distance matrix
tasDist <- rTASSEL::distanceMatrix(tasObj = tasGenoPhenoFilt)
tasDistRMat <- rTASSEL::distanceToRMatrix(tasDist)
tasDistRMat[1:5, 1:5]

# Calculate BLUEs
tasBLUE <- rTASSEL::assocModelFitter(
  tasObj = tasPhenoDF,
  formula = list(BW8, GLUCOM) ~ .,                  # <- All data is used!
  fitMarkers = FALSE,
  kinship = NULL,
  fastAssociation = FALSE,
  maxP = 0.001
)
tasBLUE
# Association test began
# formula is 'list(BW8, GLUCOM) ~ location + SEX'

# 1. GLM
tasGLM <- rTASSEL::assocModelFitter(
  tasObj = tasGenoPhenoFilt,           
  formula = list(BW8, GLUCOM) ~ SEX, 
  fitMarkers = TRUE,            
  kinship = NULL,
  fastAssociation = FALSE, 
  maxP = 0.001, 
  outputFile = "./GLM"
)
# Return GLM output
tasGLM

# 2. MLM
tasMLM <- rTASSEL::assocModelFitter(
  tasObj = tasGenoPhenoFilt,             
  formula = . ~ .,               
  fitMarkers = TRUE, 
  kinship = tasKin,                  
  fastAssociation = FALSE, 
  maxP = 0.1, 
  outputFile = "./MLM"
)
# Return MLM output
tasMLM

# 3. 