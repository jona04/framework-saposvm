function [A,B] = busca_intervalo_quad(p,a,b,c,l,u)
A = 0;
B = 0;
n = length(p);
for k=1:10^6
    xA = xis_quad(-k,p,b,a,l,u,n);
    xB = xis_quad(k,p,b,a,l,u,n);
    gA = b'*(xA) - c;
    gB = b'*(xB) - c;
    if gA*gB < 0
        A = -k;
        B = k;
        break;
    end
end
end

