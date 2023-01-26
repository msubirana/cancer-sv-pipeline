#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
vcf_in=args[1]
vcf_out=args[2]


BiocManager::install("StructuralVariantAnnotation")

# SIMPLE_TYPE defines type of SV
library(VariantAnnotation)
library(StructuralVariantAnnotation)
library(stringr)
#' Simple SV type classifier
simpleEventType <- function(gr) {
  pgr = partner(gr)
  return(ifelse(seqnames(gr) != seqnames(pgr), "CTX", # inter-chromosomosal
    ifelse(strand(gr) == strand(pgr), "INV",
      ifelse(gr$insLen >= abs(gr$svLen) * 0.7, "INS", # TODO: improve classification of complex events
        ifelse(xor(start(gr) < start(pgr), strand(gr) == "-"), "DEL",
          "DUP")))))
}

vcf <- readVcf(vcf_in, "hg38")
info(header(vcf)) = unique(as(rbind(as.data.frame(info(header(vcf))), data.frame(
	row.names=c("SIMPLE_TYPE"),
	Number=c("1"),
	Type=c("String"),
	Description=c("Simple event type annotation based purely on breakend position and orientation."))), "DataFrame"))
gr <- breakpointRanges(vcf)
svtype <- simpleEventType(gr)
info(vcf)$SVLEN <- NA_character_
info(vcf[gr$sourceId])$SVTYPE <- svtype
info(vcf[gr$sourceId])$SVLEN <- gr$svLen
writeVcf(vcf, vcf_out)
