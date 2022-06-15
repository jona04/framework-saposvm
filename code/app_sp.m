function [pk,ak,fxk] = app_esfv1(m,xkant,xk,P,a)
%
%
fxk = -(a')*xk + (1/2)*(xk)'*P*xk;
fxkant = -(a')*xkant + (1/2)*(xkant)'*P*xkant;
%
s = xkant-xk;
gf0 = (P*xk-a);
divider = norm(s)^2;
result = 2*(fxkant - fxk - (gf0')*s)/divider;
c2i_f0 = max(10e-60, result);
ak = -gf0 + c2i_f0*xk;
pk = ones(m,1)*c2i_f0;
end
 