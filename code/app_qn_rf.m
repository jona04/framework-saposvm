function [xda, kda] = app_v3_rf(n,A,a,b,c,l,u,eps)
xkant = (1/n)*ones(n,1);
xk = ones(n,1); xk(n) = c/2;xk(1) = c/2;
b0 = diag(A);
[pk,ak] = app_qn(n,xkant,xk,A,a,b0);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);
for k=1:1000
    [Lfp,xfp,kfp] = regula_falsi_solver(pk,ak,b,c,l,u,eps);
    if abs(Lfp - L0) < eps
        break;
    end
    L0 = Lfp;
    xkant = xk;
    xk = xfp;
    b0 = pk;
    [pk,ak] = app_qn(n,xkant,xk,A,a,b0); 
end
xda = xk;
kda = k;
end