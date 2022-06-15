function acc = calculate_accuracy_lssvm(test_data,test_label, supportVectors,supportVectorLabels, sigma,alphas,bias)

    K = get_gauss_kernel(test_data,supportVectors,sigma);
    y_hat = sign(sum(K.*repmat(alphas'.*supportVectorLabels',size(test_data,1),1),2) + bias);
           
    acc = mean(test_label==y_hat);
end