function [pk,ak,gfant] = app_qc(n,xkant,xk,P,a,gfant,first)
Pxk=P*xk;
gf = (Pxk-a);
pk = norm(gf);
if first == false
    s = xk-xkant;
    y= gf-gfant;
          
    pk = ((s'*y)/(s'*s));
end

ak = -gf + pk*xk;
pk = pk*ones(n,1);

gfant = gf;

end
 