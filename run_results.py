'''
Script that runs all the synthetic tests for the paper.
'''
from subprocess import call, check_output
import os

# Set of tests types and sizes
results_dir = 'results/'
tests_medians = {"result_medians_sp.txt":"Spherical approximation",
                    "result_medians_qc.txt":"quasi-Couchy approximation"}
acronym = {"result_medians_sp.txt":"Sp", "result_medians_qc.txt":"Qc"}
c=[1,100,1000]
bases = ['mnist','heart','australian','german numer','fourclas', 'ionosphere','sonar','splice']
sigmas=[
    [8,8.5,8.5],
    [3,10,10],
    [8,9.5,9.5],
    [5.5,1,1],
    [0.1,0.1,0.1],
    [2,1,1],
    [2,3,3],
    [3,3,3]
];

if __name__ == '__main__':
    # Rebuild the benchmark.
    call(['make', 'clean'])
    call(['make'])

    # Generate report in LaTeX format.
    os.chdir(results_dir)
    latex = check_output(['python2', '../summarize.py', 'latex'])
    out = file('framework_results.tex', 'w')
    out.write(latex)
    out.close()
    os.chdir('..')
