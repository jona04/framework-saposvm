% Calcula X(Lambda)
function [xb,Sbl,Sbu,Sbap,Sbbp] = xis_quad(lambda,p,b,a,l,u,n)
       

xb = (a - lambda*b)./p;

Sbl = 0; Sbu = 0; Sbap = 0; Sbbp = 0;
% xL = xb;

for j=1:n
%     xb = ( a(j) - lambda*b(j) ) / p(j);

    if xb(j) <= l(j)
        Sbl = Sbl + b(j)*l(j);
        xb(j) = l(j);
    else
        if xb(j) >= u(j)
            Sbu = Sbu + b(j)*u(j);
            xb(j) = u(j);
        else
            Sbap = Sbap + (b(j)*a(j))/p(j);
            Sbbp = Sbbp + (b(j)*b(j))/p(j);
        end
    end
end