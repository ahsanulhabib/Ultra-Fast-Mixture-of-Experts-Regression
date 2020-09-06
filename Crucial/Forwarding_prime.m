function [Hardmean,Softmean]=Forwarding_prime(parameters,...
    fv,clfx,y_train,oldfolder,combo1)
X_test=(parameters);
cd(oldfolder);

%%
% Answerhard=cell(2,1);
% Answersoft=cell(2,1);
for ii=1:2
% fprintf('Predicting measurement %d | %d .\n', ii,2);   
folderk = fv; 

switch combo1
    case 1

cd(folderk)    
    
       
Classifiers=load('Classifiers'); 
Classifiers=Classifiers.Classifiers;

Experts=load('Experts.out');


clfysses=load('clfysses'); 
clfysses=clfysses.clfysses;

% clfy = MinMaxScalery();
% (clfy.fit(y_train(:,ii)));


Regressors=load('Regressors');
Regressors=Regressors.Regressors;  


Xtrainbig=load('Xtrainbig');
Xtrainbig=Xtrainbig.Xtrainbig;

ytrainbig=load('ytrainbig');
ytrainbig=ytrainbig.ytrainbig;

[Hardmean(:,ii),Hardvariance(:,ii)]=prediction_1(Regressors{ii,1},...
    pred_class(X_test, Classifiers{ii,1})...
,X_test,Xtrainbig{ii,1},ytrainbig{ii,1},Experts,clfysses{ii,1});
[Softmean(:,ii),Softvariance(:,ii)]=Unseen_soft_1(Regressors{ii,1},...
    Classifiers{ii,1},X_test,Xtrainbig{ii,1},ytrainbig{ii,1}...
,Experts,clfysses{ii,1});

    case 2

cd(folderk)       
    
% disp('Expert=DNN, Gate=DNN')
Classifiers=load('Classifiers'); 
Classifiers=Classifiers.Classifiers;

Experts=load('Experts.out');

Classallsbig=load('Classallsbig');
Classallsbig=Classallsbig.Classallsbig;

clfysses=load('clfysses'); 
clfysses=clfysses.clfysses;

Regressors=load('Regressors');
Regressors=Regressors.Regressors;  

% cd(oldfolder)
[Hardmean(:,ii)]=prediction_2(Regressors{ii,1},pred_class(X_test...
    , Classifiers{ii,1})...
,X_test,Classallsbig{ii,1},Experts,clfysses{ii,1});

[Softmean(:,ii)]=Unseen_soft_2(Regressors{ii,1},...
    Classifiers{ii,1},X_test,Classallsbig{ii,1},...
Experts,clfysses{ii,1});
    case 3

cd(folderk)
Classifiers=load('Classifiers'); 
Classifiers=Classifiers.Classifiers;

Experts=load('Experts.out');

Classallsbig=load('Classallsbig');
Classallsbig=Classallsbig.Classallsbig;


clfysses=load('clfysses'); 
clfysses=clfysses.clfysses;

Regressors=load('Regressors');
Regressors=Regressors.Regressors;  

% cd(oldfolder)
[Hardmean(:,ii),Hardvariance(:,ii)]=prediction_3(Regressors{ii,1}...
    ,str2double(predict(Classifiers{ii,1},X_test))...
,X_test,Classallsbig{ii,1},Experts,clfysses{ii,1});

[Softmean(:,ii),Softvariance(:,ii)]=Unseen_soft_3(Regressors{ii,1}...
    ,Classifiers{ii,1},X_test,Experts,clfysses{ii,1});    
%     
end
 cd(oldfolder)
end



end