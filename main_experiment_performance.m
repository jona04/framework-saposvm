clc;
clear;
close all;

list = [];

sigmas=[
    [8,8.5,8.5]
];
sets = [
    "./data/mnist.txt";
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
        sementes = 30;
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

            %% SP-MPF
            tic;
            [xpf,kpf] = app_sp_mpf(n,A,a,b,c,l,u,eps);
            tsppf = toc;
            %%

            %% SP-Secant
            tic;
            [xsc,ksc] = app_sp_sec(n,A,a,b,c,l,u,eps);
            tspsc = toc;
            %%

            %% SP-Regula falsi
            tic;
            [xrf,krf] = app_sp_rf(n,A,a,b,c,l,u,eps);
            tsprf = toc;
            %%

            %% SP-Bisection
            tic;
            [xbs,kbs] = app_sp_bis(n,A,a,b,c,l,u,eps);
            tspbs = toc;
            %%

            %% LS-SVM
            supportVectors      = X;
            supportVectorLabels = y;
            tic;
            [bias,alphas] = lssvm_train(K,y, gamma);
            tlib = toc;
            %%
            
            %% QC-MPF
            tic;
            [xpf,kpf] = app_qc_mpf(n,A,a,b,c,l,u,eps);
            tqcpf = toc;
            %%

            %% QC-Secant
            tic;
            [xsc,ksc] = app_qc_sec(n,A,a,b,c,l,u,eps);
            tqcsc = toc;
            %%

            %% QC-Regula falsi
            tic;
            [xrf,krf] = app_qc_rf(n,A,a,b,c,l,u,eps);
            tqcrf = toc;
            %%

            %% QN-Bisection
            tic;
            [xbs,kbs] = app_qc_bis(n,A,a,b,c,l,u,eps);
            tqcbs = toc;
            %%

            %% QN-MPF
            tic;
            [xpf,kpf] = app_qn_mpf(n,A,a,b,c,l,u,eps);
            tqnpf = toc;
            %%

            %% QN-Secant
            tic;
            [xsc,ksc] = app_qn_sec(n,A,a,b,c,l,u,eps);
            tqnsc = toc;
            %%

            %% QN-Regula falsi
            tic;
            [xrf,krf] = app_qn_rf(n,A,a,b,c,l,u,eps);
            tqnrf = toc;
            %%

            %% QN-Bisection
            tic;
            [xbs,kbs] = app_qn_bis(n,A,a,b,c,l,u,eps);
            tqnbs = toc;
            %%

            Rt = [Rt;tsppf tspsc tsprf tspbs tlib tqcpf tqcsc tqcrf tqcbs tqnpf tqnsc tqnrf tqnbs];
            
            % if it is the first iteration
            if s==1 && i==1 && k==1
                list = [tsppf tspsc tsprf tspbs tlib tqcpf tqcsc tqcrf tqcbs tqnpf tqnsc tqnrf tqnbs];
            else
                list = vertcat( list,[tsppf tspsc tsprf tspbs tlib tqcpf tqcsc tqcrf tqcbs tqnpf tqnsc tqnrf tqnbs] );
            end

        end
        
        %%
        disp('A comparison with different methods - mean values');
        disp(['Dataset = ',+dataname,+',   C = ',+num2str(C),+',    Sigma = ',+num2str(sigma),+'    n = ',+num2str(n)]);
    end
end

writematrix(list,'results/result_performance_sp.txt');
