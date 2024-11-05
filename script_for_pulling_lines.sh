#!/bin/bash
input_difference=$1
output_pulling_lines=$2

# Find max value in column 2 and corresponding value in column 1
max_reference=$(zless "$input_difference" | awk 'BEGIN {max = -1e100} {if ($2 > max) max = $2} END {print max}')
max_reference_length=$(zless "$input_difference" | awk 'BEGIN {max = -1e100} {if ($2 > max) {max = $2; max_ref_length = $1}} END {print max_ref_length}')

# Calculate lines to pull based on max values
zless "$input_difference" | awk -v max_ref="$max_reference" -v max_len="$max_reference_length" '{lines_to_pull = ($2 / max_ref) * max_len; print $1, "\t", lines_to_pull}' > "$output_pulling_lines"
