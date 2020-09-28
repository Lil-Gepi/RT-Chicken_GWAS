#!/bin/sh
# get the id of all generation 2
bcftools query -l /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006115.5_Chr28_K10nGen19_SCOREHWE_no294BadSm.vcf.gz | grep 02$ > /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt
# -S means read the file with sample names. -Oz means compressed output. -o is the output file
# take out the genotype data that are only from the sample id of our interest, thus shrinking the filesize. 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr1_gen2.vcf.gz /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006088.5_Chr1_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr2_gen2.vcf.gz /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006089.5_Chr2_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr3_gen2.vcf.gz /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006090.5_Chr3_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr4_gen2.vcf.gz /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006091.5_Chr4_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr5_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006092.5_Chr5_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr6_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006093.5_Chr6_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr7_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006094.5_Chr7_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr8_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006095.5_Chr8_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr9_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006096.5_Chr9_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr10_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006097.5_Chr10_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr11_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006098.5_Chr11_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr12_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006099.5_Chr12_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr13_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006100.5_Chr13_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr14_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006101.5_Chr14_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr15_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006102.5_Chr15_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr16_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006103.5_Chr16_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr17_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006104.5_Chr17_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr18_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006105.5_Chr18_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr19_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006106.5_Chr19_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr20_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006107.5_Chr20_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr21_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006108.5_Chr21_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr22_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006109.5_Chr22_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr23_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006110.5_Chr23_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr24_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006111.5_Chr24_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr25_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006112.4_Chr25_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr26_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006113.5_Chr26_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr27_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006114.5_Chr27_K10nGen19_SCOREHWE_no294BadSm.vcf.gz 
bcftools view -S /home/yiwen/RT-Chicken_GWAS/gen2_sample_id.txt -Oz -o /home/yiwen/RT-Chicken_GWAS/chr28_gen2.vcf.gz  /home/yiwen/nas/STITCH_imputed_genotypes_F1_to_F18/STITCH_NC_006115.5_Chr28_K10nGen19_SCOREHWE_no294BadSm.vcf.gz
bcftools concat -Oz -o chr_all_gen2.vcf.gz /home/yiwen/RT-Chicken_GWAS/*.vcf.gz

