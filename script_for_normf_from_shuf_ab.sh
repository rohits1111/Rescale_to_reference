#!/bin/bash
input_file1=$1
input_file2=$2
output_difference=$3
output_combined=$4

(zcat "$input_file2" | awk 'BEGIN {OFS="\t"} {$4=""; print $0}' ; zcat "$input_file1") | tr ' ' '\t' > "$output_combined"


zless $output_combined | awk '{print $4}' > combined_length.tsv

#Sorting of the file 
zless combined_length.tsv | sort -n | uniq -c > sorted_combined_length.tsv

# Calculate the total from the frequency column and store it in a variable
total=$(zless sorted_combined_length.tsv | awk '{total += $1} END {print total}')

# Normalize the second column and print the original line along with the normalized value
zless sorted_combined_length.tsv | awk  -v total="$total" '{normalized = $1 / total; print $2, normalized}' > normalised_sorted.tsv

# Create intermediate temporary files
cut -d ' ' -f 1-2 reference.hist > temp_ref_cols.tsv
tr -s ' ' ' ' < normalised_sorted.tsv | cut -d ' ' -f 2 > temp_norm_cols.tsv

# Use `paste` to combine them
paste temp_ref_cols.tsv temp_norm_cols.tsv > file_normalised.tsv

# Clean up temporary files
rm temp_ref_cols.tsv temp_norm_cols.tsv


#Finding Max difference point
zless file_normalised.tsv | awk '{print $0 ,$2-$3}'  | tr ' ' '\t' >  $output_difference
