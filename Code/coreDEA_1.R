## DEA Core script 1. Read data and build rhe RCCset
# Input: RCC files
# Output: counts matrix and metadata dataframe
# Based on `https://github.com/hbc/clark-nanostring`, `https://rawgit.com/hbc/clark-nanostring/master/tumor-set/tumor-set.html#t-test`, `http://bioconductor.org/packages/devel/bioc/vignettes/NanoStringQCPro/inst/doc/vignetteNanoStringQCPro.pdf`





##### Libraries ######
source("/Users/javi/Desktop/R-workspace/NAC_DEA/Code/0_loadlibraries.R")
#source("/Users/aurelio/Library/Mobile Documents/com~apple~CloudDocs/sandbox/R-dev/myfunctions/basics.R")
loadpkg("NanoStringQCPro")
loadpkg("dplyr")
loadpkg("readr")
loadpkg("matrixStats")
loadpkg("tidyr")
##### Functions #####


#####################

# # set seed to be reproduciblish
# set.seed(12345)
# DataDir <- "/Users/aurelio/Dropbox/CIMES/data/per/expresion/" # All the data for this project will be located in Dropbox
# rccDir <- file.path(DataDir, "RCCData")

### Load data
# The samplefiles for this project are named according to pre/post NAC (key1) and pCR (key2)

#metadata <- data.frame(fname=list.files(rccDir, pattern="*.RCC")) %>%
#        tidyr::separate(fname,c("Sample.name","key1","key2"),sep="_",remove=F) %>%
#        tidyr::separate(key2, c("key2", "ext"), sep="\\.") %>%
#        dplyr::select (fname,Sample.name, key1, key2) 




# Get the right RCC files into an RCCSet

getcountsfromRCC <- function(sampletype){
        rccSet <- newRccSet(
                rccFiles               = file.path(rccDir, sampletype$fname)
                #,rccCollectorToolExport = file.path(exampleDataDir, "nSolver", "RCC_collector_tool_export.csv")
                ,rlf                    = file.path(DataDir,  "RLFData/NS_CancerPath_C2535.rlf")
                #,cdrDesignData          = file.path(exampleDataDir, "CDR", "CDR-DesignData.csv")
                #,extraPdata             = file.path(exampleDataDir, "extraPdata", "SampleType.txt")
                #,blankLabel             = "blank"
                # ,experimentData.name    = ""
                # ,experimentData.lab     = " "
                # ,experimentData.contact = ""
                # ,experimentData.title   = ""
                # ,experimentData.abstract= ""
        )
        colnames(rccSet) <- sampletype$Sample.name
        return(rccSet@assayData$exprs) # Return the counts matrix
}

getRCCSet <- function(sampletype){
        rccSet <- newRccSet(
                rccFiles               = file.path(rccDir, sampletype$fname)
                #,rccCollectorToolExport = file.path(exampleDataDir, "nSolver", "RCC_collector_tool_export.csv")
                ,rlf                    = file.path(DataDir, "RLFData/NS_CancerPath_C2535.rlf")
                #,cdrDesignData          = file.path(exampleDataDir, "CDR", "CDR-DesignData.csv")
                #,extraPdata             = file.path(exampleDataDir, "extraPdata", "SampleType.txt")
                #,blankLabel             = "blank"
                # ,experimentData.name    = ""
                # ,experimentData.lab     = " "
                # ,experimentData.contact = ""
                # ,experimentData.title   = ""
                # ,experimentData.abstract= ""
        )
        colnames(rccSet) <- sampletype$Sample.name
        return(rccSet) # Return the RCC expression set
}

getCounts <- function(eset, metadata){
  return(exprs(eset)[, metadata$Sample.name])
}

