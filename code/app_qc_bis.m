function [xda, kda] = app_v2_bis(n,A,a,b,c,l,u,eps1)
xkant = (1/n)*ones(n,1);
xk = ones(n,1); xk(n) = c/2;xk(1) = c/2;
gfant = (A*xkant-a);
[pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant);
L0 = (((ak./pk)'*b) - c)/((b./pk)'*b);
for k=1:1000
    [Lbs,xbs,kbs] = bisection_solver(pk,ak,b,c,l,u,eps1);
    if abs(Lbs - L0) < eps1
        break;
    end
    L0 = Lbs;
    xkant = xk;
    xk = xbs;
    [pk,ak,gfant] = app_qc(n,xkant,xk,A,a,gfant); 
end
xda = xk;
kda = k;
end