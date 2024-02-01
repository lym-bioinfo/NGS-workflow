#!/bin/bash

# 设置输入文件路径和输出路径
input_dir="/home/kampo314/TGAPJACHIP/trimmed"
output_dir="/home/kampo314/TGAPJACHIP/mapped"

# 进入输入文件路径
cd "$input_dir"

# 遍历每个_1.fastq文件
for file_1 in *_1.fq.gz; do
  # 提取文件名前缀
  prefix="${file_1%_1.fq.gz}"
  
  # 构造_2.fastq文件名
  file_2="${prefix}_2.fq.gz"

  # 设置输出文件名前缀
  output_prefix="${prefix}_mapped"

  # 运行bowtie2命令进行mapping
  bowtie2 -x /home/kampo314/RAP-DB_bowtie2/RAP -1 "$file_1" -2 "$file_2" -S "$output_dir/$output_prefix.sam" -p 16
  
  echo "Completed mapping for $file_1 and $file_2"
done
