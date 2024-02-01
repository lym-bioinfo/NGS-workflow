#!/bin/bash

input_dir="/home/kampo314/TGAP_MT"
output_dir="/home/kampo314/TGAP_MT/trimmed"

mkdir -p "$output_dir"

for file in "$input_dir"/*.fastq.gz; do

  filename=$(basename "$file" .fastq)
  
  trim_galore -stringency 3 -q 25 --length 80 -j 8 --output_dir "$output_dir" "$file"
  
  mv "$output_dir"/"${filename}_trimmed.fastq" "$output_dir"/"${filename}_trimmed.fastq"
done
