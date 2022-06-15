function K = get_gauss_kernel( Xa,Xb,sigma )
% RBF

% according with the formula 
% exp( - gamma || Xa - Xb ||^2 )

% K=zeros(size(Xa,1),size(Xb,1));%Gram Matrix
% for i=1:size(Xa,1)
%     for j=1:size(Xb,1)
%         K(i,j)=exp(-gamma*norm(Xa(i,:)-Xb(j,:))^2);
%     end
% end

u=Xa;
v=Xb;
K = exp(-(1/(2*sigma^2))*(repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))...
                -2*(u*v')+repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)));


end

