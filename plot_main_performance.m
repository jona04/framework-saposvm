clc;
clear;
close all;

result = readmatrix('./results/result_performance.txt');

np = 50; % number of problems;
ns = 9;  % number of schemes 

%% Generating the performance profile C=1
R = zeros(ns,np);
it=1;
for i=1:50
    linha = result(i,:);
    R(1,it) = linha(1);      %es-pf
    R(2,it) = linha(2);      %es-sc
    R(3,it) = linha(3);      %es-rf
    R(4,it) = linha(4);      %es-bs
    R(5,it) = linha(5);      %lssvm
    R(6,it) = linha(6);      %qc-pf
    R(7,it) = linha(7);      %qc-sc
    R(8,it) = linha(8);      %qc-rf
    R(9,it) = linha(9);      %qc-bs
    it = it+1;
end
R = R';
[t,f1,f2,f3,f4,f5,f6,f7,f8,f9] = plot_performance(R,np,ns);

%% Generating the performance profile C=100
R = zeros(ns,np);
it=1;
for i=51:100
    linha = result(i,:);
    R(1,it) = linha(1);      %es-pf
    R(2,it) = linha(2);      %es-sc
    R(3,it) = linha(3);      %es-rf
    R(4,it) = linha(4);      %es-bs
    R(5,it) = linha(5);      %lssvm
    R(6,it) = linha(6);      %qc-pf
    R(7,it) = linha(7);      %qc-sc
    R(8,it) = linha(8);      %qc-rf
    R(9,it) = linha(9);      %qc-bs
    it = it+1;
end
R = R';
[tt,f11,f22,f33,f44,f55,f66,f77,f88,f99] = plot_performance(R,np,ns);

%% Generating the performance profile C=1000
R = zeros(ns,np);
it=1;
for i=101:150
    linha = result(i,:);
    R(1,it) = linha(1);      %es-pf
    R(2,it) = linha(2);      %es-sc
    R(3,it) = linha(3);      %es-rf
    R(4,it) = linha(4);      %es-bs
    R(5,it) = linha(5);      %lssvm
    R(6,it) = linha(6);      %qc-pf
    R(7,it) = linha(7);      %qc-sc
    R(8,it) = linha(8);      %qc-rf
    R(9,it) = linha(9);      %qc-bs
    it = it+1;
end
R = R';
[ttt,f111,f222,f333,f444,f555,f666,f777,f888,f999] = plot_performance(R,np,ns);

figure(1)
plot(t,f1,'black:o',t,f2,'black:+',t,f3,'black:p',t,f4,'black:<',t,f5,'black:v',t,f6,'black:x',t,f7,'black:>',t,f8,'black:*',t,f9,'black:d',linewidth=1);
title('C=1','FontSize',16)
legend('Sp-fp','Sp-sc','Sp-rf','Sp-bs','LSSVM','Qc-fp', 'Qc-sc','Qc-rf','Qc-bs','FontSize',13);
ylabel('\rho_a (\tau)','FontSize',16) 
xlabel('\tau','FontSize',16) 

figure(2)
plot(tt,f11,'black:o',tt,f22,'black:+',tt,f33,'black:p',tt,f44,'black:<',tt,f55,'black:v',tt,f66,'black:x',tt,f77,'black:>',tt,f88,'black:*',tt,f99,'black:d',linewidth=1);
title('C=100','FontSize',16)
legend('Sp-fp','Sp-sc','Sp-rf','Sp-bs','LSSVM','Qc-fp', 'Qc-sc','Qc-rf','Qc-bs','FontSize',13);
ylabel('\rho_a (\tau)','FontSize',16) 
xlabel('\tau','FontSize',16) 

figure(3)
plot(ttt,f111,'black:o',ttt,f222,'black:+',ttt,f333,'black:p',ttt,f444,'black:<',ttt,f555,'black:v',ttt,f666,'black:x',ttt,f777,'black:>',ttt,f888,'black:*',ttt,f999,'black:d',linewidth=1);
title('C=1000','FontSize',16)
legend('Sp-fp','Sp-sc','Sp-rf','Sp-bs','LSSVM','Qc-fp', 'Qc-sc','Qc-rf','Qc-bs','FontSize',13);
ylabel('\rho_a (\tau)','FontSize',16) 
xlabel('\tau','FontSize',16) 
