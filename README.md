# GWAS | ant Restriction site-associated DNA sequencing (RAD-seq)


#### reads mapping
```
bwa index GCF_013373865.1_ASM1337386v2_genomic.fna
bwa mem GCF_013373865.1_ASM1337386v2_genomic.fna {input} > {output}
```
#### sam to bam
```
samtools faidx GCF_013373865.1_ASM1337386v2_genomic.fna
samtools view -bhS -t GCF_013373865.1_ASM1337386v2_genomic.fna.fai {id}.sam -o {id}.bam
```
#### sort bam
```
samtools sort {id}.bam -o {id}.sorted.bam
```
#### remove PCR duplication
```
picard MarkDuplicates I=input.bam O=deduplicated.bam REMOVE_DUPLICATES=true M=marked_dup_metrics.txt
picard MarkDuplicates I={id}.bam O={id}.rmd.bam REMOVE_DUPLICATES=true M={id}.txt
```
