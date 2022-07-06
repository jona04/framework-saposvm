function [pk,ak,fxk] = app_sp(m,xkant,xk,P,a,first)
fxk = -(a')*xk + (0.5)*(xk)'*P*xk;
gf0 = (P*xk-a);
c2i_f0 = norm(gf0);
if first == false
    fxkant = -(a')*xkant + (0.5)*(xkant)'*P*xkant;
    s = xkant-xk;
    divider = norm(s)^2;
    gf0s=(gf0')*s;
    result = 2*(fxkant - fxk - gf0s)/divider;
    c2i_f0 = max(10e-60, result);
end

ak = -gf0 + c2i_f0*xk;
pk = ones(m,1)*c2i_f0;
end
 