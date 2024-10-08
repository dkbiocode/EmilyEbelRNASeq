#!/bin/bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=htmlSummaryLoop
#SBATCH --output=%x.%j.out
#SBATCH --time=0:30:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo

outfile="HTMLOutput.tsv"
#echo "Duplication Rate  Reads Passed  Total Reads Q20 Bases Q30 Bases" > ${outfile}
echo -e "Sample Name\tDuplication Rate\tReads Passed\tTotal\tQ20 Bases\tQ30 Bases" > ${outfile}

for FILE in *.html
do

	dup=$(grep "duplication rate:" $FILE | grep -o "[0-9]\+\.[0-9]\+%")

	#Don't want the percentage here....

	reads_pass=$(grep "reads passed filters:" $FILE | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")
	#Split above into 2? Just get percentage?

	tot_reads=$(grep "total reads:" $FILE | grep -o "[0-9]\+\.[0-9]\+\s[GMK]")
	#Need to determine before or after filtering

	q_20=$(grep "Q20 bases" $FILE -m 1 | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")

	q_30=$(grep "Q30 bases" $FILE -m 1 | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")

	#write_line="${FILE} ${dup} ${reads_pass}  ${tot_reads}  ${q_20} ${q_30}"

	write_line="${FILE}\t${dup}\t${reads_pass}\t${tot_reads}\t${q_20}\t${q_30}"

	echo -e ${write_line}

	echo -e ${write_line} >> ${outfile}
done

