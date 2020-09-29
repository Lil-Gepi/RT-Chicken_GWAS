## 2020.09.28
Drop bear finally got rJava and rTASSEL installed, the place where R expects to find various Java files wasn't updated when Tilman runned the commands last Friday and now it's solved by running the following line.<br>

    sudo R CMD javareconf JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

## 2020.09.29 <br>
Tried to load the gen2_allchr.vcf.gz into rTASSEL, however got the error message as the data can not be loaded. Codes as follow:<br>

    tasGenoDF <- rTASSEL::readGenotypeTableFromPath(path = "/home/yiwen/nas/all_gen2.vcf.gz")
    log4j:WARN No appenders could be found for logger (net.maizegenetics.plugindef.AbstractPlugin).
    log4j:WARN Please initialize the log4j system properly.
    Error in .jcall("RJavaTools", "Ljava/lang/Object;", "invokeMethod", cl,  :
    java.lang.IllegalStateException: ImportUtils: read: nothing was loaded for: /home/yiwen/nas/all_gen2.vcf.gz
Two options are in my head, one is to re-generate the vcf file that I concatenated from the 28 chrs' data, and maybe we can give .vcf format a try, to see if the proble is caused by the compression; the other chance is to switch to TASSEL and see if the problem is caused by rTASSEL, since the behavior of rJava is rather weird, this is quite possible the problem. 
