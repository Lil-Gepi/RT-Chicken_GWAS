##This is the QC procedures
##1: Missingness of SNPs and individuals
##2: Sex discrepancy
##3: Minor allele frequency (MAF)
##4: Hardy–Weinberg equilibrium (HWE)
##5: Heterozygosity
##6: Relatedness
##(X)7: Population stratification
tasGenoPhenoFilt <- rTASSEL::filterGenotypeTableSites(
  siteRangeFilterType = "none",
  tasObj = tasGenoPheno,
  siteMinCount = 10,
  siteMinAlleleFreq = 0.05,
  siteMaxAlleleFreq = 1.0
)
tasGenoPhenoFilt
tasGenoPheno
