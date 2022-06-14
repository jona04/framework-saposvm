function [L,xfp,kfp] = fixedpoint_solver(L0,p,a,b,c,l,u,eps1)
    L = L0;
    %(((a./p)'*b) - c)/((b./p)'*b);
    n = length(a);

    original_b = b;
    if min(b) < 0
        [a,b,l,u] = convert_to_positiveb(n,a,b,l,u);
    end

    for k=1:10
        Lant = L;
        %%%%%%%%%%%%%%%%%%%%%%%
        [xL,Sbl,Sbu,Sbap,Sbbp] = xis_quad(L,p,b,a,l,u,n);
        %%%%%%%%%%%%%%%%%%%%%%
        if abs(Sbbp) > 0
            L = (Sbl + Sbu + Sbap - c)/(Sbbp);
        else
            L = L + (Sbl + Sbu - c);
        end
        if abs(L - Lant) < eps1
            break;
        end
    end
    xL = sign(original_b).*xL;
    kfp = k;
    xfp = xL;
end

function [a,b,l,u] = convert_to_positiveb(n,a,b,l,u)
    for i=1:n
       if b(i) < 0
          b(i) = -b(i); 
          a(i) = -a(i); 
          l(i) = -u(i); 
          u(i) = 0; 
       end
    end
end
