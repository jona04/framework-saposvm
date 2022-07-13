'''
Read table tests and summarize results on screen or as a latex file.
'''
import sys
import numpy as np
from run_results import c, bases, sigmas, tests_medians, acronym

# Formatting strings for Latex ouput
LATEXSTART=r'''
\documentclass[sn-chicago]{sn-jnl}%

\begin{document}
'''
LATEXEND=r'''
\end{document}
'''

CAPTION1=r'\caption{Results time and accuracy for %s}'
CAPTION2=r'\caption{Results iterations for %s and %s}'

TABLESTART1=r'''
\begin{sidewaystable}[h!]
\small
    \begin{center}
'''

TABLESTART11=r'''
        \bgroup
        \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}cccllllllllll@{\extracolsep{\fill}}}
            \toprule%
            &  &   & \multicolumn{5}{@{}c@{}}{Time}  & \multicolumn{5}{@{}c@{}}{Accuracy}     \\ \cmidrule{4-8}\cmidrule{9-13}
'''
TABLESTART22=r'''
        \bgroup
        \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}cccllllllll@{\extracolsep{\fill}}}
            \toprule%
'''
TITLES=r'&  &   & \multicolumn{4}{@{}c@{}}{%s}  & \multicolumn{4}{@{}c@{}}{%s}  \\ \cmidrule{4-7} \cmidrule{8-11}'

NAMES1=r'Name & C & Sigma & %s-fp & %s-sc & %s-rf & %s-bs & LSSVM & %s-fp & %s-sc & %s-rf & %s-bs & LSSVM \\'
NAMES2=r'Name & C & Sigma & %s-fp & %s-sc & %s-rf & %s-bs & %s-fp & %s-sc & %s-rf & %s-bs \\'

TABLEEND1=r'''
        \midrule
        \end{tabular*}
    \end{center}
\end{sidewaystable}
'''

TABLELINE1 = r'& %d  & %.2f   & %.3f    & %.3f    & %.3f    & %.3f  & %.3f & %.3f  & %.3f  & %.3f  & %.3f  & %.3f \\ '
TABLELINE2 = r'& %d  & %.2f   & %.2f    & %.2f    & %.2f    & %.2f & %.2f    & %.2f    & %.2f    & %.2f \\ '

TABLELINEBASE = r' %s  '

HLINE = r'\midrule'

def print_latex_table_medias(test,data):
    '''Print a latex representation of the test data as a table. 
    '''
    count_bases=0
    count_c=0 
    for idx,row in enumerate(data):
        sig=sigmas[count_bases][count_c]
        idx=idx+1
        if idx==1:
            print(TABLELINEBASE % bases[count_bases])
            print (TABLELINE1 % (
               c[count_c],sig, float(row[4]),float(row[5]),float(row[6]),float(row[7]),float(row[8]), float(row[9]),float(row[10]),float(row[11]),float(row[12]),float(row[13]))
                )
        else:
            print (TABLELINE1 % (
               c[count_c],sig, float(row[4]),float(row[5]),float(row[6]),float(row[7]),float(row[8]), float(row[9]),float(row[10]),float(row[11]),float(row[12]),float(row[13]))
                )
        
        count_c = count_c+1
        if(idx%3==0 and idx < len(data)):
            count_c = 0
            print(HLINE)

            count_bases=count_bases+1
            print(TABLELINEBASE % bases[count_bases])
            
def print_latex_table_medias2(data1, data2):
    '''Print a latex representation of the test data as a table. 
    '''
    count_bases=0
    count_c=0 
    for idx,row in enumerate(data1):
        sig=sigmas[count_bases][count_c]
        if idx==0:
            print(TABLELINEBASE % bases[count_bases])
            print (TABLELINE2 % (
               c[count_c],sig, float(row[0]),float(row[1]),float(row[2]),float(row[3]), float(data2[idx][0]),float(data2[idx][2]),float(data2[idx][2]),float(data2[idx][3]))
                )
        else:
            print (TABLELINE2 % (
               c[count_c],sig, float(row[0]),float(row[1]),float(row[2]),float(row[3]), float(data2[idx][0]),float(data2[idx][2]),float(data2[idx][2]),float(data2[idx][3]))
                )
        
        count_c = count_c+1
        if((idx+1)%3==0 and idx+1 < len(data)):
            count_c = 0
            print(HLINE)

            count_bases=count_bases+1
            print(TABLELINEBASE % bases[count_bases])


# Main program
if __name__ == '__main__':
    print (LATEXSTART)
    
    # Generate Time and Accuracy tables 
    for test in tests_medians:
        acron = acronym[test]
        data = np.loadtxt(test,delimiter=',')
        # Print results in the right format.
        print (TABLESTART1)
        print (CAPTION1 % tests_medians[test])
        print (TABLESTART11)
        print (NAMES1 % (acron,acron,acron,acron,acron,acron,acron,acron))
        print (HLINE)
        print_latex_table_medias(test, data)
        print (TABLEEND1)

    # Generate Time and Accuracy tables 
    acron1 = acronym[tests_medians.keys()[0]]
    acron2 = acronym[tests_medians.keys()[1]]
    data1 = np.loadtxt(tests_medians.keys()[0],delimiter=',')
    data2 = np.loadtxt(tests_medians.keys()[1],delimiter=',')
    # Print results in the right format.
    print (TABLESTART1)
    print (CAPTION2 % (tests_medians[tests_medians.keys()[0]], tests_medians[tests_medians.keys()[1]]))
    print (TABLESTART22)
    print (TITLES % (tests_medians[tests_medians.keys()[0]], tests_medians[tests_medians.keys()[1]]))
    print (NAMES2 % (acron1,acron1,acron1,acron1,acron2,acron2,acron2,acron2))
    print (HLINE)
    print_latex_table_medias2(data1,data2)
    print (TABLEEND1)

    print (LATEXEND)   