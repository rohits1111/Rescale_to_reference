#!/bin/bash

input_A=$1
output_new_nf=$2

# Generate ceiled_normalised_sorted.tsv
zless "$input_A" | awk '{ceil_freq = ($2 == int($2)) ? $2 : int($2) + 1; print $1, "\t", ceil_freq}' > ceiled_normalised_sorted.tsv

# Calculate the sum of the ceiled values
sum=$(awk '{sum += $2} END {print sum}' ceiled_normalised_sorted.tsv)

# Generate new_query_normalised_sorted.tsv with normalized values
awk -v total="$sum" '{new_nf = $2 /total; print $1, "\t", new_nf}' ceiled_normalised_sorted.tsv > new_query_normalised_sorted.tsv

# Use temporary files instead of nested process substitution
tr -s ' ' ' ' < new_query_normalised_sorted.tsv | cut -f 2 > temp_norm_cols.tsv


# Combine the processed files
paste file_normalised.tsv temp_norm_cols.tsv > $output_new_nf

# Clean up temporary files
rm temp_norm_cols.tsv ceiled_normalised_sorted.tsv
