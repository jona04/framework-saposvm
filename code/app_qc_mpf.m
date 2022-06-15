function [xda, kda] = app_v2_mpf(n,A,a,b,c,l,u,eps)
xkant = (1/n)*ones(n,1);
xk = ones(n,1); xk(n) = c/2;xk(1) = c/2;
gfant = (A*xkant-a);
[pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);
for k=1:1000
    [Lfp,xfp,kfp] = fixedpoint_solver(L0,pk,ak,b,c,l,u,eps);
    if abs(Lfp - L0) < eps
        break;
    end
    L0 = Lfp;
    xkant = xk;
    xk = xfp;
    [pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant); 
end
xda = xk;
kda = k;
end