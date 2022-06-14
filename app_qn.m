function [pk,ak,fxk] = app_qnv1(n,xkant,xk,P,a,b0)
%
%
fxk = -(a')*xk + (1/2)*(xk)'*P*xk;
fxkant = -(a')*xkant + (1/2)*(xkant)'*P*xkant;
%
B = diag(b0);
s = xkant-xk;
gf0 = (P*xk-a);
divider = norm(s)^2;
result = 2*(fxkant - fxk - (gf0')*s)/divider;
c2i_f0 = max(10e-60, result);

ak = -gf0 + c2i_f0*xk;

sk = xk - xkant;
yk = P*sk;

A = diag(sk.^2);
B = B + ((sk'*yk + sk'*sk - sk'*B*sk)/trace(A*A))*A - eye(n,n);
%pk = diag(B);
%        
pk = ((sk'*yk)/(sk'*sk))*ones(n,1);
end
 