function [pk,ak,gfant] = app_qcv1(n,xkant,xk,P,a,gfant)

gf = (P*xk-a);

s = xk-xkant;
y= gf-gfant;
      
pk = ((s'*y)/(s'*s));

ak = -gf + pk*xk;
pk = pk*ones(n,1);

gfant = gf;

end
 