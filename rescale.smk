rule all:
    input:
        "Difference_a_b.bed"
        "to_pull.tsv",
        "final_file_normalised.tsv",
        "line_plot.png"
        
rule for_Normalised_freq_from_shuf_ab_file:
    input:
         "shuf.a.bed.gz",  
         "shuf.b.bed.gz"   
    output:
        "Difference_a_b.bed",  
        "combined_shuf_ab.bed",
          
    shell:
        "./script_for_normf_from_shuf_ab.sh {input[0]} {input[1]} {output[0]} {output[1]}"

rule for_Pulling:
    input:
        "Difference_a_b.bed"
    output:
        "to_pull.tsv"
    shell:
        "./script_for_pulling_lines.sh Difference_a_b.bed to_pull.tsv"

rule for_Calculating_new_norm_freq:
    input:
        "to_pull.tsv",
    output:
        "final_file_normalised.tsv"
    shell:
        "./script_for_subsampled_new_nf.sh to_pull.tsv final_file_normalised.tsv"

rule for_Plotting:
    input:
        "final_file_normalised.tsv"
    output:
        "line_plot.png"
    shell:
        "python3 graph_plot.py final_file_normalised.tsv line_plot.png"





    


    




