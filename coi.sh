input_dir="/home/kampo314/coi_project"
trimmed_output_dir="/home/kampo314/coi_project/trimmed"
mapped_output_dir="/home/kampo314/coi_project/mapped"

mkdir -p "$trimmed_output_dir"
mkdir -p "$mapped_output_dir"

cd "$input_dir"
for file_1 in *_1.fastq; do
  prefix="${file_1%_1.fastq}"
  file_2="${prefix}_2.fastq"
  trimmed_prefix="${prefix}_t"
  trim_galore --paired "$file_1" "$file_2" --output_dir "$trimmed_output_dir" --basename "$trimmed_prefix" -j 18 -q 30 --length 80 --stringency 3
  echo "Completed trimming for $file_1 and $file_2"
  trimmed_file_1="${trimmed_output_dir}/${trimmed_prefix}_val_1.fq.gz"
  trimmed_file_2="${trimmed_output_dir}/${trimmed_prefix}_val_2.fq.gz"
  mapped_prefix="${prefix}_m"
  dart -i /home/kampo314/RAP2024/XXX -f "$trimmed_file_1" -f2 "$trimmed_file_2" -bo "$mapped_output_dir/$mapped_prefix.bam" -t 18 -mis 1
  echo "Completed mapping for $trimmed_file_1 and $trimmed_file_2"
done
