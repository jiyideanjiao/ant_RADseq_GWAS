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
samtools sort {id}.bam -o {id}.srt.bam
```
#### remove PCR duplication
```
picard MarkDuplicates I={id}.srt.bam O={id}.rmd.bam REMOVE_DUPLICATES=true M={id}.txt
samtools rmdup {id}.srt.bam {id}_nopcr.bam
```
#### call variants
```
bcftools mpileup -f <ReferenceGenome> <All file names> | bcftools call --skip-variants indels --variants-only -mv -Oz -o output.vcf.gz
```
#### filter variants
```
vcftools 
```
#### convert to dosage
```
bcftools +dosage behavior_filter.vcf > behavior.dosage
bcftools +dosage chc_filter.vcf > chc.dosage
```
