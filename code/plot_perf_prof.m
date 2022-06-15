function plot_perf_prof(R)
c = R'; %% Transfer results;
np = 100; % number of problems;
ns = 6;  % number ofschemes
clf();
cmin = zeros(1,ns);

for p=1:np
    cmin(p) = min(c(1:ns,p));
end

R = zeros(ns,np);

for s=1:ns
    for p=1:np
        R(s,p) = c(s,p)/cmin(p);
    end
end

%
% Discretizando t para calcular f(s,t)
%
tmax = max(max(R))+0.1;
tmin = 1;
t = [tmin:0.01:tmax];
% calculando f(s,t) = fs(t)
for j=1:length(t)
    f1(j)=(length(find(R(1,:)<=t(j))))/np;
    f2(j)=(length(find(R(2,:)<=t(j))))/np;
    f3(j)=(length(find(R(3,:)<=t(j))))/np;
    f4(j)=(length(find(R(4,:)<=t(j))))/np;
    f5(j)=(length(find(R(5,:)<=t(j))))/np;
    f6(j)=(length(find(R(6,:)<=t(j))))/np;
end
%
% plot(t,f1,t,f2);
%
plot(t,f1,t,f2,t,f3,t,f4,t,f5,t,f6);
hold on;
legend('PF','SC','RF','BS','LB','QP');
%legend('LA', 'BS', 'RF', 'SC');
end
