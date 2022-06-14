clc;
clear;
close all;

list_medians = [];

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
sets = [
    "./data/mnist.txt";
    "./data/heart_scale.txt";
    "./data/australian_scale.txt" ;
    "./data/german_numer_scale.txt";
    "./data/fourclass_scale.txt" ;
    "./data/ionosphere_scale.txt" ;
    "./data/sonar_scale.txt" ;
    "./data/splice_scale.txt";
    ]
for s=1:length(sets)
    dataname = [char(sets(s))]; 
    [label, instances] = libsvmread(dataname);
    
    instances_original = full(instances);
    instances = full(instances);
    
    scale=1;
    if (dataname == "./data/mnist.txt")
        instances = normalize(instances, 'range', [-1*scale 1*scale]);
    end
    
    sigma_b = sigmas(s,:);

    CC = [1,100,1000];
    for i=1:3
        C = CC(i);
        sigma = sigma_b(i);

        Rt = []; Ra = []; Rk = [];
        sementes = 50;
        for k=1:sementes
            
            [X,y,X_test,train_data,train_label,test_data,test_label] = tansform_data(label, instances);

            n_features = size(train_data,2);

            % used in lssvm
            gamma = C;

            %% Kernel
            % choose the kernel - we user the Gaussian Kernel or RBF
            K = get_gauss_kernel(X,X,sigma);

            %% get SVM quadratic problem
            [A,a,b,c,l,u] = get_quad_problem(X,y,C,K);

            n_exemples_test = size(test_data,1);
            n = size(train_data,1);
            
            eps = 10^(-4);

            %% MPF
            tic;
            [xpf,kpf] = app_qc_mpf(n,A,a,b,c,l,u,eps);
            tpf = toc;
            apf = calculate_accuracy(xpf,X,y,sigma,X_test,test_label);
            %%

            %% Secant
            tic;
            [xsc,ksc] = app_qc_sec(n,A,a,b,c,l,u,eps);
            tsc = toc;
            asc = calculate_accuracy(xsc,X,y,sigma,X_test,test_label);
            %%

            %% Regula falsi
            tic;
            [xrf,krf] = app_qc_rf(n,A,a,b,c,l,u,eps);
            trf = toc;
            arf = calculate_accuracy(xrf,X,y,sigma,X_test,test_label);
            %%

            %% Bisection
            tic;
            [xbs,kbs] = app_qc_bis(n,A,a,b,c,l,u,eps);
            tbs = toc;
            abis = calculate_accuracy(xbs,X,y,sigma,X_test,test_label);
            %%

            %% LS-SVM
            supportVectors      = X;
            supportVectorLabels = y;
            tic;
            [bias,alphas] = lssvm_train(K,y, gamma);
            tlib = toc;klb = 1;
            alb = calculate_accuracy_lssvm(test_data,test_label, supportVectors,supportVectorLabels, sigma,alphas,bias);
            %%

            Rt = [Rt;tpf tsc trf tbs tlib];
            Ra = [Ra;apf asc arf abis alb];
            Rk = [Rk;kpf ksc krf kbs klb];

        end
        
        %%
        disp('A comparison with different methods - mean values');
        disp(['Dataset = ',+dataname,+',   C = ',+num2str(C),+',    Sigma = ',+num2str(sigma),+'    n = ',+num2str(n)]);
        disp('Alg   It.      Time            Accuracy');
        disp('------------------------------------------------------------');
        disp(['PF',+'  | ', +num2str(mean(Rk(:,1))),+'  | ',+num2str(mean(Rt(:,1))),+' | ',+num2str(mean(Ra(:,1)))]);
        disp(['SC',+'  | ', +num2str(mean(Rk(:,2))),+'  | ',+num2str(mean(Rt(:,2))),+' | ',+num2str(mean(Ra(:,2)))]);
        disp(['RF',+'  | ', +num2str(mean(Rk(:,3))),+'  | ',+num2str(mean(Rt(:,3))),+'  | ',+num2str(mean(Ra(:,3)))]);
        disp(['BS',+'  | ', +num2str(mean(Rk(:,4))),+'  | ',+num2str(mean(Rt(:,4))),+'  | ',+num2str(mean(Ra(:,4)))]);
        disp('----');
        disp(['LSSVM ',+' | ', +num2str(mean(Rk(:,5))),+'    | ',+num2str(mean(Rt(:,5))),+'  | ',+num2str(mean(Ra(:,5)))]);

        % if it is the first iteration
        if s==1 && i==1 && k==1
            list_medians = [mean(Rk(:,1)),mean(Rk(:,2)),mean(Rk(:,3)),mean(Rk(:,4)),mean(Rt(:,1)),mean(Rt(:,2)),mean(Rt(:,3)),mean(Rt(:,4)),mean(Rt(:,5)),mean(Ra(:,1)),mean(Ra(:,2)),mean(Ra(:,3)),mean(Ra(:,4)),mean(Ra(:,5))];
        else
            list_medians = vertcat( list_medians,[mean(Rk(:,1)),mean(Rk(:,2)),mean(Rk(:,3)),mean(Rk(:,4)),mean(Rt(:,1)),mean(Rt(:,2)),mean(Rt(:,3)),mean(Rt(:,4)),mean(Rt(:,5)),mean(Ra(:,1)),mean(Ra(:,2)),mean(Ra(:,3)),mean(Ra(:,4)),mean(Ra(:,5))]);
        end
    end
end

disp('------------------------------------------------------------');
disp('PF = Fixed point');
disp('SC = Secant');
disp('RF = Regula falsi');
disp('BS = Bisection');
disp('----');
disp('LSSVM = Least Square SVM');
disp('------------------------------------------------------------');

writematrix(list_medians,'results/result_medians_qc.txt');

