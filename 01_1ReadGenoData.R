
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