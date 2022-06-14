function [L,x,k] = regula_falsi_solver(p,a,b,c,l,u,eps1)
[A,B] = busca_intervalo_quad(p,a,b,c,l,u);
n = length(p);
for k=1:10^3
    xA = xis_quad(A,p,b,a,l,u,n);
    xB = xis_quad(B,p,b,a,l,u,n);
    gA = b'*xA - c;
    gB = b'*xB - c;
    L = (A*gB - B*gA)/(gB - gA);
    xL = xis_quad(L,p,b,a,l,u,n);
    gL = b'*xL - c;
    if abs(gL) < eps1
        break;
    end
    if sign(gL) == sign(gA)
        A = L;
    else
        B = L;
    end
end
x = xL;
end