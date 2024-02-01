# 设置输入文件夹和输出文件夹路径
input_dir="/home/kampo314/momiara/trimmed"
output_dir="/home/kampo314/momiara/mapped"

# 创建输出文件夹
mkdir -p "$output_dir"

# 遍历每个_1.fastq文件
for file_1 in *_1.fq.gz; do
  # 提取文件名前缀
  prefix="${file_1%_1.fq.gz}"
  
  # 构造_2.fastq文件名
  file_2="${prefix}_2.fq.gz"

  # 设置输出文件名前缀
  output_prefix="${prefix}_mapped"

  # 运行bowtie2命令进行mapping
  dart -i /home/kampo314/arabi_genome/TAIR10 -f "$file_1" -f2 "$file_2" -bo "$output_dir/$output_prefix.bam" -t 18 -mis 1
  
  echo "Completed mapping for $file_1 and $file_2"
done
