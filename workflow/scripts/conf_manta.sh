#!/bin/bash

manta=$1
tumorBam=$2
normalBam=$3
referenceFasta=$4
runDir=$5

$manta \
--tumorBam $tumorBam \
--normalBam $normalBam \
--referenceFasta $referenceFasta \
--runDir $runDir
