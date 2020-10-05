## 2020.09.25
Had the meeting with group, decided that I shall work on dropbear with Rstudio Server and then I'll need to install rJava and rTASSEL on dropbear as well which is a bit porblematic without sudo previlige. I wrote a bash script so that Tilman or Yunzhou can run it with sudo for me.
[script for installing rJava and rTASSEL](https://github.com/Lil-Gepi/RT-Chicken_GWAS/blob/master/install_rJava_rTASSEL.sh)

## 2020.09.28
Dropbear finally got rJava and rTASSEL installed, the place where R expects to find various Java files wasn't updated when Tilman runned the commands last Friday and now it's solved by running the following line.<br>

    sudo R CMD javareconf JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

## 2020.09.29 <br>
Tried to load the gen2_allchr.vcf.gz into rTASSEL, however got the error message as the data can not be loaded. Codes as follow:<br>

    tasGenoDF <- rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/nas/all_gen2.vcf.gz")
        log4j:WARN No appenders could be found for logger (net.maizegenetics.plugindef.AbstractPlugin).
        log4j:WARN Please initialize the log4j system properly.
        Error in .jcall("RJavaTools", "Ljava/lang/Object;", "invokeMethod", cl,  :
          java.lang.IllegalStateException: ImportUtils: read: nothing was loaded for: /home/yiwen/nas/all_gen2.vcf.gz
Two options are in my head, one is to re-generate the vcf file that I concatenated from the 28 chrs' data, and maybe we can give .vcf format a try, to see if the proble is caused by the compression; the other chance is to switch to TASSEL and see if the problem is caused by rTASSEL, since the behavior of rJava is rather weird, this is quite possible the problem. 

## 2020.09.30
The error seems to be caused by the vcf file not sorted by the snps' position for some reason. After adding additional parameter as _sortPositions = T_ when loading the vcf, I am now waiting the result. Otherwise there's a plugin of TASSEL as _SortGenotypeFilePlugin_ . We can try use it after the failure of rTASSEL.

## 2020.10.01
It seems like the error previously encountered was indeed caused by bcftools concatenating the snps based on their chromosomes with an order as 1,10,11,12...19,2,20,...which is not understandable to Tassel. Very fortunately, rTASSEL has the option mentioned above when reading in the data.<br>
Today I'm also aiming to filter out "bad" snps with low frequency  

## 2020.10.02
When trying to extract genotype data from tasGenoPheno object, there's always an  error message:
    
    Error in .jcall("RJavaTools", "Ljava/lang/Object;", "invokeMethod", cl,  java.lang.NegativeArraySizeException: -1763385218
Fixing thins, otherwise it might be caused by the size, we can see whathappens with the association test first.

