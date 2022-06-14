'''
Read table tests and summarize results on screen or as a latex file.
'''
import sys
import numpy as np
from run_tests import c, bases, sigmas, tests_medians

# Formatting strings for Latex ouput
LATEXSTART=r'''
\documentclass[sn-chicago]{sn-jnl}%

\begin{document}
'''
LATEXEND=r'''
\end{document}
'''
TABLESTART=r'''
\begin{sidewaystable}[h!]
\small
    \begin{center}
        \caption{Results for Gaussian kernel function and spherical approximation}
        \label{resultadoSpGussiana}
        \bgroup
        \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}cccllllllllll@{\extracolsep{\fill}}}
            \toprule%
            &  &   & \multicolumn{5}{@{}c@{}}{Time}  & \multicolumn{5}{@{}c@{}}{Accuracy}     \\ \cmidrule{4-8}\cmidrule{9-13}
            Name & C & Sigma & Sp-fp & Sp-sc & Sp-rf & Sp-bs & LSSVM & Sp-fp & Sp-sc & Sp-rf & Sp-bs & LSSVM \\
        \midrule
'''
TABLEEND=r'''
        \midrule
        \end{tabular*}
    \end{center}
\end{sidewaystable}
'''
TABLELINE = r'& %d  & %.2f   & %.3f    & %.3f    & %.3f    & %.3f  & %.3f & %.3f  & %.3f  & %.3f  & %.3f  & %.3f \\ '
TABLELINEBASE = r' %s  '
HLINE = r'\midrule'

def print_latex_table_medias(data):
    '''Print a latex representation of the test data as a table. 
    '''
    count_bases=0
    count_c=0 
    for idx,row in enumerate(data):
        sig=sigmas[count_bases][count_c]
        idx=idx+1
        if idx==1:
            print(TABLELINEBASE % bases[count_bases])
            print (TABLELINE % (
               c[count_c],sig, float(row[4]),float(row[5]),float(row[6]),float(row[7]),float(row[8]), float(row[9]),float(row[10]),float(row[11]),float(row[12]),float(row[13]))
                )
        else:
            print (TABLELINE % (
               c[count_c],sig, float(row[4]),float(row[5]),float(row[6]),float(row[7]),float(row[8]), float(row[9]),float(row[10]),float(row[11]),float(row[12]),float(row[13]))
                )
        
        count_c = count_c+1
        if(idx%3==0 and idx < len(data)):
            count_c = 0
            print(HLINE)

            count_bases=count_bases+1
            print(TABLELINEBASE % bases[count_bases])
            
            

def latex_report_medias(test, data):
    '''Print the full report of the test data in latex format.
    '''
    # Compute statistics.

    print_latex_table_medias(data)

    print('')

# Main program
if __name__ == '__main__':
    print (LATEXSTART)
    
    for test in tests_medians:
        data = np.loadtxt(test,delimiter=',')
        # Print results in the right format.

        print (TABLESTART)
        latex_report_medias(test, data)
        print (TABLEEND)


    print (LATEXEND)   