function [xda, kda] = app_v1_mpf(n,A,a,b,c,l,u,eps)
xkant = (1/n)*ones(n,1);
xk = ones(n,1); xk(n) = c/2;xk(1) = c/2;
[pk,ak] = app_sp(n,xkant,xk,A,a);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);
for k=1:1000
    [Lfp,xfp,kfp] = fixedpoint_solver(L0,pk,ak,b,c,l,u,eps);
    if abs(Lfp - L0) < eps
        break;
    end
    L0 = Lfp;
    xkant = xk;
    xk = xfp;
    [pk,ak] = app_sp(n,xkant,xk,A,a); 
end
xda = xk;
kda = k;
end