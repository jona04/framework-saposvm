This repository contains all the code implementing the Framework SapoSVM as described in the manuscript

 * A. Alves, J.O.L. Silva, L.C. Matioli, P.S.M. Santos. "A new framework for training
 Support Vector Machines".


If you run into problems please do not hesitate to  contact me:

* Jonatas O. L. Silva <jonatas.iw@gmail.com>

## Directory organization

* code/ : Directory containing the methods implementation necessary to run all experiments

* data/ : Directory containing the datasets used in the experiments

* results/ : Directory which will stores the results after run the file run_results.py

*  main_experiment_performance.m : Run this to generate inside of the folder results/ the txt files necessary to plot the performance profile according to the Section 4.2 of the paper

*  main_experiment_qc.m : Run this to generate inside of the folder results/ the txt file responsible to generate the experiments using the quasi-Couchy approximation in step 1 of the framework

*  main_experiment_sp.m : Run this to generate inside of the folder results/ the txt file responsible to generate the experiments using the spherical approximation in step 1 of the framework

*  plot_main_performance.m.m : Run this to plot the profile performance according to the txt file in results/ folder

* run_results.py : Run this to generate the .tex file inside of results/ folder 

Obs: run the  file run_results.py only after generate the .txt files using main_experiment_qc.m, main_experiment_qn.m and main_experiment_sp.m

* summarizy.py : Code in Python with scripts used to generate the .tex file


## Generating table results

To generate Tables 7, 8 and 9 presented in the paper please follow the steps below:

1 - Open the Matlab and run the files:
    main_experiment_qn.m, main_experiment_qc.m and main_experiment_sp.m. After it three .txt files will be generated. The process can during some minutes.

2 - Run the command below:

      python run_results.py

Then, inside of the folder results/ a file .tex will be created containing the three tables presented in the paper


## Generating performance profile


1 - Open the Matlab and run the file main_experiment_performance.m. After it a .txt file will be generated.

2 - Open the Matlab and run the file plot_main_performance.m. After it three figures will be generated according to the paper.


## Dependencies

Instal Libsvm package according to the official documentation:

https://www.csie.ntu.edu.tw/~cjlin/libsvm/
