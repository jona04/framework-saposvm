clc;
clear;
close all;

result = readmatrix('./result_all1.txt');

np = 30; % number of problems;
ns = 10;  % number of schemes 
R = zeros(ns,np);
it=1;
for i=1:30
    linha = result(i,:);
    R(1,it) = linha(1);      %es-pf
    R(2,it) = linha(2);      %es-sc
%     R(3,it) = linha(3);      %es-rf
    R(3,it) = linha(4);      %es-bs
    R(4,it) = linha(5);      %lib
    R(5,it) = linha(6);      %qc-pf
    R(6,it) = linha(7);      %qc-sc
%     R(7,it) = linha(8);      %qc-rf
    R(7,it) = linha(9);      %qc-bs
    R(8,it) = linha(10);      %qn-pf
    R(9,it) = linha(11);      %qn-sc
%     R(11,it) = linha(12);     %qn-rf
    R(10,it) = linha(13);      %qn-bs
    it = it+1;
end
R = R';
[t,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10] = plot_performance(R,np,ns);

np = 20; % number of problems;
ns = 10;  % number of schemes 
R = zeros(ns,np);
it=1;
for i=1:30
    linha = result(i,:);
    R(1,it) = linha(1);      %es-pf
    R(2,it) = linha(2);      %es-sc
%     R(3,it) = linha(3);      %es-rf
    R(3,it) = linha(4);      %es-bs
    R(4,it) = linha(5);      %lib
    R(5,it) = linha(6);      %qc-pf
    R(6,it) = linha(7);      %qc-sc
%     R(7,it) = linha(8);      %qc-rf
    R(7,it) = linha(9);      %qc-bs
    R(8,it) = linha(10);      %qn-pf
    R(9,it) = linha(11);      %qn-sc
%     R(11,it) = linha(12);     %qn-rf
    R(10,it) = linha(13);      %qn-bs
    it = it+1;
end

figure('DefaultAxesFontSize',13)

plot(t,f1,'black:o',t,f2,'black:+',t,f3,'black:p',t,f4,'black:<',t,f5,'black:v',t,f6,'black:x',t,f7,'black:>',t,f8,'black:*',t,f9,'black:d',t,f10,'black:s',linewidth=1);
title('C=1')
legend('Sp-fp','Sp-sc','Sp-bs','libsvm','Qc-fp', 'Qc-sc','Qc-bs','Qn-fp','Qn-sc','Qn-bs');
ylabel('\rho_a (\tau)') 
xlabel('\tau') 
% xticks(1:4:49);

