# GWAS | ant Restriction site-associated DNA sequencing (RAD-seq)


#### reads mapping
```
bwa index GCF_013373865.1_ASM1337386v2_genomic.fna
bwa mem GCF_013373865.1_ASM1337386v2_genomic.fna {input} > {output}
```
#### transform sam to bam
```
samtools faidx GCF_013373865.1_ASM1337386v2_genomic.fna
samtools view -bhS -t GCF_013373865.1_ASM1337386v2_genomic.fna.fai {id}.sam -o {id}.bam
```
