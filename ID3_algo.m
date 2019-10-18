function []= ID3_algo(a,n)
%Run the for loop for n numebr of times
for k=1:n
    % Generating 1*150 random variable matrix
    rows=randperm(150);
    A = dlmread('/Users/sai/Documents/MATLAB/ID32/Data.txt');
    %data discrimination methods
    if strcmp(a,"naive")
        [A_disc] = round(A);
    else
        
        [ A_disc,a,b ] = cacc(A);
    end
    fprintf("=============================================================== \n")
    fprintf("RUN: %d\n",k);
    %dividing training and test data equaly
    train_rows=transpose(rows(1,1:100));
    test_rows=transpose(rows(1,101:150));
    DataTrain_allcols=A_disc(train_rows,:);
    DataTest_allcols=A_disc(test_rows,:);

    %selecting first 4 colomns for traing and testing
    training_data=DataTrain_allcols(:,1:4);
    testing_data=DataTest_allcols(:,1:4);

    %Gets max enropy: Code taken from www.mathworks.com/matlabcentral/fileexchange/14996-entropy
    [BIG rootIndex]=getBestEnt(DataTrain_allcols(:,5),training_data);
    attributes_names=["Sepal_length","Sepal_width","Petal_length","Petal_width"];
    tree = struct('value', 'null', 'first', 'null','second','null', 'third', 'null','fourth','null','fifth','null','sixth','null','seventh','null','eight','null','nine','null','ten','null');
    tree.value=attributes_names(rootIndex);
    tree= getNextNode_val(training_data,DataTrain_allcols(:,5),rootIndex,tree,training_data,attributes_names);
    %select random rows less than 75 to test training data
    randomTestRows=transpose(randperm(100,95));
    fprintf("Training Data Results");
    %fprintf("\n**************************\n");
    for i=1:size(randomTestRows,1)
        testRow_tmp=training_data(randomTestRows(i),:);
        pred(i)=DataTrain_allcols(randomTestRows(i),5);
        yval(i)=findClass(tree,testRow_tmp,attributes_names,training_data);
    end
    %Finding Accuracy for training data
    printClassMetrics (pred , yval, 1)
    fprintf("Test Data Results");
    %fprintf("\n**************************\n");
    %select random rows less than 75 for test data
    randomTestRows=transpose(randperm(50,50));

    for i=1:size(randomTestRows,1)
        testRow_tmp=testing_data(randomTestRows(i),:);
        pred(i)=DataTest_allcols(randomTestRows(i),5);
        yval(i)=findClass(tree,testRow_tmp,attributes_names,training_data);
    end
    %finding the accuracy for test data 
    printClassMetrics (pred , yval, 1)
    %ConfMat (yval,pred)
    %displaying confusion matrix
    cm = confusionchart(yval,pred);
end
end