function [bias, alphas] = lssvm_train(K,y_train, gamma)

    %% Matriz Omega            

    OMEGA = K .* (y_train* y_train') + (1/gamma) * eye(size(K));
    
    A = [0 y_train'; y_train OMEGA];
    b = [0; ones(size(OMEGA, 1), 1)];
    
    result = A\b; 
    
    bias = result(1,1);
    alphas = result(2:end,1);

end