function [L,x,k] = bisection_solver(p,a,b,c,l,u,eps1)
n = length(p);
% Bisection method:
[A,B] = busca_intervalo_quad(p,a,b,c,l,u);
xA = xis_quad(A,p,b,a,l,u,n);
xB = xis_quad(B,p,b,a,l,u,n);
gA = b'*(xA) - c;
gB = b'*(xB) - c;
for k=1:10^3
    L = (A + B)/2;
    xL = xis_quad(L,p,b,a,l,u,n);
    gL = b'*(xL) - c;
    if abs(gL) < eps1
        break;
    end
    if (gA*gL > 0)
        A = L;
        xA = xL;
        gA = gL;
    else
        if (gA*gL < 0)
            B = L;
            xB = xL;
            gB = gL;
        end
    end
end
x = xis_quad(L,p,b,a,l,u,n);
end