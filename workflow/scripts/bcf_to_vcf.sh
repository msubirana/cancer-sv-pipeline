#!/bin/env bash

bcf=$1
vcf=$2

bcftools view $bcf > $vcf