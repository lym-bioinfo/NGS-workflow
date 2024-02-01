#!/bin/bash

input_dir="/home/kampo314/TGAPJACHIP"
output_dir="/home/kampo314/TGAPJACHIP/trimmed"

cd "$input_dir"

for file_1 in *_1.fastq.gz; do
  prefix="${file_1%_1.fastq.gz}"
  file_2="${prefix}_2.fastq.gz"
  output_prefix="${prefix}_trimmed"

  trim_galore --paired "$file_1" "$file_2" --output_dir "$output_dir" --basename "$output_prefix" -j 18 -q 30 --length 80 --stringency 3
  
  echo "Completed trimming for $file_1 and $file_2"
done
