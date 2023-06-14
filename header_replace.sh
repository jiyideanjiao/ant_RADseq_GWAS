sed -i 's/ /,/g' *.csv
sed -i 's/rs,allele1,af,beta,se,p_wald/chromosome,position,allele_freq,beta,se,p_wald/g' *.csv
