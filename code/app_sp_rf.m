function [xda, kda] = app_sp_rf(n,A,a,b,c,l,u,eps)
xk = zeros(n,1);
[pk,ak] = app_sp(n,[],xk,A,a,true);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);

[Lfp,xfp,kfp] = regula_falsi_solver(pk,ak,b,c,l,u,eps);
xkant = xk;
xk = xfp;
[pk,ak] = app_sp(n,xkant,xk,A,a,false); 
L0 = Lfp;
for k=1:1000
    [Lfp,xfp,kfp] = regula_falsi_solver(pk,ak,b,c,l,u,eps);
    if abs(Lfp - L0) < eps
        break;
    end
    L0 = Lfp;
    xkant = xk;
    xk = xfp;
    [pk,ak] = app_sp(n,xkant,xk,A,a,false); 
end
xda = xk;
kda = k;
end