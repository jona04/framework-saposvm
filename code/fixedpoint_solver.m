function [L,xfp,kfp] = fixedpoint_solver(L0,p,a,b,c,l,u,eps1)
    L = L0;
    n = length(a);

    [lr,ur,abp,bbp,bl,bu,x] = deal(ones(n,1));
    original_b = b;
    
    [lr,ur,abp,bbp,bl,bu,a,b,l,u] = first_config(n,p,a,b,l,u,lr,ur,abp,bbp,bl,bu);

    for k=1:50
        Lant = L;
        %%%%%%%%%%%%%%%%%%%%%%%
        [Sbl,Sbu,Sbap,Sbbp] = xis_quad_fp(L,n,lr,ur,abp,bbp,bl,bu);
        %%%%%%%%%%%%%%%%%%%%%%

        L = (Sbl + Sbu + Sbap - c)/(Sbbp);
        
        if abs(L - Lant) < eps1
            xL = mount_x(n,L,p,a,b,l,u,lr,ur,x);
            break;
        end
    end
    xL = sign(original_b).*xL;
    kfp = k;
    xfp = xL;
end

function [lr,ur,abp,bbp,bl,bu,a,b,l,u] = first_config(n,p,a,b,l,u,lr,ur,abp,bbp,bl,bu)
    for i=1:n

        if b(i) < 0
          b(i) = -b(i); 
          a(i) = -a(i); 
          l(i) = -u(i); 
          u(i) = 0; 
        end

        lr(i) = (a(i)-p(i)*l(i))/b(i);
        ur(i) = (a(i)-p(i)*u(i))/b(i);
        abp(i) = (a(i)*b(i))/p(i);
        bbp(i) = (b(i)*b(i))/p(i);
        bl(i) = b(i)*l(i);
        bu(i) = b(i)*u(i);
        
    end
end

function x = mount_x(n,lambda,p,a,b,l,u,lr,ur,x)
    for j=1:n
        if lambda >= lr(j)
            x(j) = l(j);
        else
            if lambda <= ur(j)
                x(j) = u(j);
            else
                x(j) = (a(j) - lambda * b(j))/p(j);
            end
        end
    end
end
