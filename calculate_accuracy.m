function accuracy_mpf = calculate_accuracy(alpha,X,y,gamma,X_test,test_label)
    a_m = alpha;
    a_m(a_m<10^-5)=0;
    X_m = X(a_m>0,:);
    Y_m = y(a_m>0);
    a_m = a_m(a_m>0);
    
    Kb = get_gauss_kernel(X,X_m,gamma);
    
    b_m = mean(y-Kb*(a_m.*Y_m));
    
    K = get_gauss_kernel(X_test,X_m,gamma);
    
    main_pred = K *(a_m.*Y_m) + b_m>0;
    main_pred = main_pred*2-1;
    accuracy_mpf = mean(main_pred==(test_label));
end