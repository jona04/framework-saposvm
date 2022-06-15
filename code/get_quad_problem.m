function [P,a,b,c,l,u] = get_quad_problem(X,y,C,K)

    P = (y*y').*K;
    n= length(y);
    %
    l = zeros(n,1);
    u = C*ones(n,1);
    a = ones(n,1);
    b = y;
    c=0;

end