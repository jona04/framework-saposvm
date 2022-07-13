function [xda, kda] = app_sp_bis(n,A,a,b,c,l,u,eps1)
xk = zeros(n,1);
[pk,ak] = app_sp(n,[],xk,A,a,true);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);

[Lfp,xfp,kfp] = bisection_solver(pk,ak,b,c,l,u,eps);
xkant = xk;
xk = xfp;
[pk,ak] = app_sp(n,xkant,xk,A,a,false); 
L0 = Lfp;
for k=1:1000
    [Lbs,xbs,kbs] = bisection_solver(pk,ak,b,c,l,u,eps1);
    if abs(Lbs - L0) < eps1
        break;
    end
    L0 = Lbs;
    xkant = xk;
    xk = xbs;
    [pk,ak] = app_sp(n,xkant,xk,A,a,false); 
end
xda = xk;
kda = k;
end