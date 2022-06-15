function [L2,x,k] = secant_solver(L0,p,a,b,c,l,u,eps1)
% secant method:
%[A,B] = busca_intervalo_w2(b,d,g,c,l,u);
%[A,B] = refina_intervalo_fixo(A,B,a,c,l,u);
L1 = L0/2;
n = length(p);
for k=1:10^3
    xL0 = xis_quad(L0,p,b,a,l,u,n);
    xL1 = xis_quad(L1,p,b,a,l,u,n);
    gL0 = b'*(xL0) - c;
    gL1 = b'*(xL1) - c;
    L2 = L1 - ((L1 - L0)/(gL1 - gL0))*gL1;
    xL2 = xis_quad(L2,p,b,a,l,u,n);
    gL2 = b'*(xL2) - c;
    if abs(gL2) < eps1
        break;
    end
    L0 = L1;
    L1 = L2;
end
x = xis_quad(L2,p,b,a,l,u,n);
end