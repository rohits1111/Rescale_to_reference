import pandas as pd
import matplotlib.pyplot as plt

# Reading the CSV file
data_df = pd.read_csv("final_file_normalised.tsv", sep="\t", header=None)
data_df.columns = ['Length','Ref_freq','Old_query_nf','New_query_nf']

# Extracting the columns for plotting
x = data_df['Length']
y1 = data_df['Ref_freq']       
y2 = data_df['Old_query_nf']       
y3 = data_df['New_query_nf']   

# Plotting the data
plt.plot(x, y1, 'k--', label='Reference')
plt.plot(x, y2, 'r-', label='Old_query')
plt.plot(x, y3, 'y-', label='New_query')

# Setting plot titles and labels
plt.title('RESCALING_TO_REFERENCE')
plt.xlabel('Length')
plt.ylabel('Norm_freq')

# Adding legend and saving the figure
plt.legend(loc=0)
plt.savefig("line_plot.png")  # Save before plt.show()
plt.show()