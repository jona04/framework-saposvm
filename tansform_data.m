function [X,y,X_test,train_data,train_label,test_data,test_label]= tansform_data(label, instances)

    n = length(instances);
    
    i = randperm(n,round(0.7*n));
    
    train_data = instances(i,:); 
    test_data  = instances(setdiff(1:n,i),:);
    train_label = label(i,:); 
    test_label  = label(setdiff(1:n,i),:);

    train_data = full(train_data);
    train_label = full(train_label);
    test_data = full(test_data);
    test_label = full(test_label);

    X = train_data;
    y = train_label;
    X_test = test_data;
end