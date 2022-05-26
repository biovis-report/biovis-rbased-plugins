library(configr)
library(maftools)
library(dplyr)

config <- read.config(file = 'shiny.ini')
dataConfig <- config$data
attributes <- config$attributes

if (dataConfig$dataType == 'maf') {
    rawData <- maftools::read.maf(maf=dataConfig$dataFile)
} else if (dataConfig$dataType == 'rds') {
    rawData <- readRDS(dataConfig$dataFile)
} else if (dataConfig$dataType == 'csv') {
    rawData <- read.csv(dataConfig$dataFile, header=TRUE)
}

getVector <- function(value) {
    if (!is.null(value)) {
        return(as.vector(as.matrix(value)))
    } else {
        return(NULL)
    }
}

getBool <- function(value) {
    if (value %in% c('True', 'TRUE', 'T', '1')) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

getInt <- function(value) {
    if (!is.null(value)) {
        int <- as.integer(as.vector(as.matrix(value)))
        if (is.na(int)) {
            int <- 0
        }
        return(int)
    } else {
        return(0)
    }
}

data <- rawData

attrs <- list(
    title=getVector(attributes$title),
    subtitle=getVector(attributes$subtitle),
    text=getVector(attributes$text),
    queryURL=getVector(attributes$queryURL),
    showpanel=getBool(getVector(attributes$showpanel)),
    gene=getVector(attributes$gene),
    AACol=getVector(attributes$AACol),
    labPosSize=getInt(getVector(attributes$labPosSize)),
    showMutationRate=getBool(getVector(attributes$showMutationRate)),
    labelPos=getVector(attributes$labelPos),
    showDomainLabel=getBool(getVector(attributes$showDomainLabel)),
    cBioPortal=getBool(getVector(attributes$cBioPortal)),
    repel=getBool(getVector(attributes$repel)),
    collapsePosLabel=getBool(getVector(attributes$collapsePosLabel)),
    legendTxtSize=getInt(getVector(attributes$legendTxtSize)),
    labPosAngle=getInt(getVector(attributes$labPosAngle)),
    domainLabelSize=getInt(getVector(attributes$domainLabelSize)),
    printCount=getBool(getVector(attributes$printCount)),
    colors=getVector(attributes$colors),
    axisTextSize=getVector(attributes$axisTextSize),
    domainColors=getVector(attributes$domainColors),
    labelOnlyUniqueDoamins=getBool(getVector(attributes$labelOnlyUniqueDoamins)),
    defaultYaxis=getBool(getVector(attributes$defaultYaxis)),
    titleSize=getVector(attributes$titleSize),
    pointSize=getInt(getVector(attributes$pointSize))
)
