function [t,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10] = plot_performance(R,np,ns)
c = R'; %% Transfer results;
% np = 50; % number of problems;
% ns = 4;  % number of schemes 
clf();
cmin = zeros(1,ns);

for p=1:np
    val_min = min(c(1:ns,p));
    cmin(p) = val_min;
     
end

R = zeros(ns,np);

for s=1:ns
    for p=1:np
        if c(s,p) == 100
            R(s,p) = false;
            
        else
            result = c(s,p)/cmin(p);
            R(s,p) = result;
        end
    end
end

%
% Discretizando t para calcular f(s,t)
%
tmax = max(max(R))+1; 
tmin = 1;
t = [tmin:1:tmax];
% calculando f(s,t) = fs(t)
for j=1:length(t)
   f1(j)=(length(find(R(1,:)<=t(j))))/np;
   f2(j)=(length(find(R(2,:)<=t(j))))/np;
   f3(j)=(length(find(R(3,:)<=t(j))))/np;
   f4(j)=(length(find(R(4,:)<=t(j))))/np;
   f5(j)=(length(find(R(5,:)<=t(j))))/np;
   f6(j)=(length(find(R(6,:)<=t(j))))/np;
   f7(j)=(length(find(R(7,:)<=t(j))))/np;
   f8(j)=(length(find(R(8,:)<=t(j))))/np;
   f9(j)=(length(find(R(9,:)<=t(j))))/np;
   f10(j)=(length(find(R(10,:)<=t(j))))/np;
%    f11(j)=(length(find(R(11,:)<=t(j))))/np;
%    f12(j)=(length(find(R(12,:)<=t(j))))/np;
%    f13(j)=(length(find(R(13,:)<=t(j))))/np;
end


% plot(t,f1,'b',t,f2,'m',t,f3,'k',t,f4,'g',linewidth=2);
% hold on;
% legend('Libsvm', 'Quadprog', 'SQSD-MPF', 'SQSD-MFV');

end