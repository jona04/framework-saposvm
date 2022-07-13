function [xda, kda] = app_qc_sec(n,A,a,b,c,l,u,eps)
xk = zeros(n,1);
[pk,ak,gfant] = app_qc(n,[],xk,A,a,[],true);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);

[Lfp,xfp,kfp] = secant_solver(L0,pk,ak,b,c,l,u,eps);
xkant = xk;
xk = xfp;
[pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant,false); 
L0 = Lfp;
for k=1:1000
    [Lfp,xfp,kfp] = secant_solver(L0,pk,ak,b,c,l,u,eps);
    if abs(Lfp - L0) < eps
        break;
    end
    L0 = Lfp;
    xkant = xk;
    xk = xfp;
    [pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant,false); 
end
xda = xk;
kda = k;
end