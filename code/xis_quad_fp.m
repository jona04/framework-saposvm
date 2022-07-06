% Calcula X(Lambda)
function [Sbl,Sbu,Sbap,Sbbp] = xis_quad_fp(lambda,n,lr,ur,abp,bbp,bl,bu)

Sbl = 0; Sbu = 0; Sbap = 0; Sbbp = 0;

for j=1:n
    if lambda >= lr(j)
        Sbl = Sbl + bl(j);
    else
        if lambda <= ur(j)
            Sbu = Sbu + bu(j);
        else
            Sbap = Sbap + abp(j);
            Sbbp = Sbbp + bbp(j);
        end
    end
end