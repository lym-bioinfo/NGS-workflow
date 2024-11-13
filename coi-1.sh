input_dir="/home/kampo314/coi_project"
trimmed_output_dir="/home/kampo314/coi_project/trimmed"
mapped_output_dir="/home/kampo314/coi_project/mapped"
sorted_output_dir="/home/kampo314/coi_project/sorted"
log_file="/home/kampo314/coi_project/process_log.txt"

mkdir -p "$trimmed_output_dir"
mkdir -p "$mapped_output_dir"
mkdir -p "$sorted_output_dir"

: > "$log_file"

cd "$input_dir"
for file_1 in *_1.fastq; do
  prefix="${file_1%_1.fastq}"
  file_2="${prefix}_2.fastq"
  trimmed_prefix="${prefix}_t"
  
  conda activate trim_galore_env
  trim_galore --gzip --paired "$file_1" "$file_2" --output_dir "$trimmed_output_dir" --basename "$trimmed_prefix" -j 18 -q 30 --length 80 --stringency 3 &>> "$log_file"
  echo "Completed trimming for $file_1 and $file_2" >> "$log_file"
  conda deactivate
  
  trimmed_file_1="${trimmed_output_dir}/${trimmed_prefix}_val_1.fq.gz"
  trimmed_file_2="${trimmed_output_dir}/${trimmed_prefix}_val_2.fq.gz"
  
  conda activate dart_env
  mapped_prefix="${prefix}_m"
  
  dart -i /home/kampo314/RAP2024/XXX -f "$trimmed_file_1" -f2 "$trimmed_file_2" -bo "$mapped_output_dir/$mapped_prefix.bam" -t 18 -mis 1 &>> "$log_file"
  echo "Completed mapping for $trimmed_file_1 and $trimmed_file_2" >> "$log_file"
  conda deactivate

  conda activate samtools_env
  sorted_bam="${sorted_output_dir}/${mapped_prefix}_sorted.bam"
  samtools sort -@ 18 -o "$sorted_bam" "$mapped_output_dir/$mapped_prefix.bam" &>> "$log_file"
  echo "Completed sorting for $mapped_prefix.bam" >> "$log_file"
  conda deactivate

  rm "$trimmed_file_1" "$trimmed_file_2" "$mapped_output_dir/$mapped_prefix.bam"
  echo "Deleted intermediate files for $prefix" >> "$log_file"
done

echo "FINISHED" >> "$log_file"
