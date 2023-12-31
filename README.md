# GWAS | Ant RAD-seq


#### reads mapping
```
bwa index GCF_013373865.1_ASM1337386v2_genomic.fna
bwa mem GCF_013373865.1_ASM1337386v2_genomic.fna {input} > {output}
```
#### convert sam file to bam file
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
bcftools mpileup -f <ReferenceGenome> <All file names> |
bcftools call --skip-variants indels --variants-only -mv -Oz -o output.vcf.gz
```
#### filter variants
```
vcftools --vcf chc.vcf --maf 0.05 --max-alleles 2 --minQ 30 --minDP 5 --recode --stdout > chc_filter.vcf
```
#### convert variant file to dosage file
```
bcftools +dosage behavior_filter.vcf > behavior.dosage
bcftools +dosage chc_filter.vcf > chc.dosage
```
#### estimate kinship file (relatedness)
```
gemma -g behavior.dosage -p behavior_phenotype.txt -gk 1 -o relatedness_behavior
gemma -g chc.dosage -p chc_phenotype.txt -gk 1 -o relatedness_chc
```
#### run GEMMA
```
gemma -g ant.dosage -p phenotype.PhenoResiduals.txt -n 3 -k relatedness.txt -lm 4 -o <trait>
gemma -g ant.dosage -p phenotype.CHCResiduals.txt -n 3 -k relatedness.txt -lm 4 -o <trait>
```
