#!/bin/bash

# Replace these variables with your specific paths and options
input_dir="/home/kampo314/MYC2RNAi/trimmed"
output_dir="/home/kampo314/MYC2RNAi/mapped"

# Loop through all the files in the input directory with ".fastq" extension
for file in "$input_dir"/*.fq.gz; do
    filename=$(basename "$file" .fq.gz)
    dart -i /home/kampo314/RAP-DB_bwa/IRGSP-1.0_genome.fasta.gz -f "$file" -mis 1 -t 18 -bo "$output_dir/$filename.bam"
done
