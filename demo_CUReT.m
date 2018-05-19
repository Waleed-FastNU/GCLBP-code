close all;clear all;clc
addpath('./helpfun');
imdir = './CURET/';
imageDatasetLabel = get_im_label(imdir);

tic;
[HistFB,HistB1,HistB2,HistB3,HistB4,HistBI,HistFB_B4,HistBI_B4,HistFB_BI,HistB2_B3,Hist_B2_B3_B4,Hist_BI_FB_B4,Hist_B3_B4_FB] = ...
calculate_GCLBP_bins(imdir, 'png');

%% classification
trail = 1; % results averaged over 100 runs
trainnum = 46;% trainning number per class  

rand('state',0);
randn('state',0);     

for i = 1:trail
    
    disp('Classification In Progress ...');
    
    % generate training and test partitions
    indextrain = [];
    indextest = [];
    labelnum = unique(imageDatasetLabel);
    for j = 1:length(labelnum)
        index = find(imageDatasetLabel == j);
        perm = randperm(length(index));
        indextrain = [indextrain index(perm(1:trainnum))];
        indextest = [indextest index(perm(trainnum+1:end))];
    end

    % Final Bin Classification
    trainfeatures = HistFB(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistFB(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistFB=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistFB(1,i) = CPHistFB;
    clear trainfeatures testfeatures DM
    
    % Noise Bin Classification
    trainfeatures = HistB1(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistB1(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistB1=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistB1(1,i) = CPHistB1;
    clear trainfeatures testfeatures DM
    
    % B2 classification
    trainfeatures = HistB2(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistB2(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistB2=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistB2(1,i) = CPHistB2;
    clear trainfeatures testfeatures DM
    
    % B3 Classification
    trainfeatures = HistB3(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistB3(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);

    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistB3=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistB3(1,i) = CPHistB3;
    clear trainfeatures testfeatures DM
    
    % Edge bin classification
    trainfeatures = HistB4(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistB4(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistB4=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistB4(1,i) = CPHistB4;
    clear trainfeatures testfeatures DM
    
    % Binary Image bin classification
    trainfeatures = HistBI(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistBI(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);

    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistBI=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistBI(1,i) = CPHistBI;
    clear trainfeatures testfeatures DM
    
    % Final Bin with Edge bin Classification 
    trainfeatures = HistFB_B4(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistFB_B4(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);

    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistFB_B4=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistFB_B4(1,i) = CPHistFB_B4;
    clear trainfeatures testfeatures DM
    
    % Binary Image bin with Edge bin Classification
    trainfeatures = HistBI_B4(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistBI_B4(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistBI_B4=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistBI_B4(1,i) = CPHistBI_B4;
    clear trainfeatures testfeatures DM
    
    % Final Bin with Binary Image Bin Classification
    trainfeatures = HistFB_BI(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistFB_BI(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistFB_BI=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistFB_BI(1,i) = CPHistFB_BI;
    clear trainfeatures testfeatures DM
    
    % B2 and B3 Texture Bins Classification
    trainfeatures = HistB2_B3(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = HistB2_B3(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHistB2_B3=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHistB2_B3(1,i) = CPHistB2_B3;
    clear trainfeatures testfeatures DM
    
    % Textures Bins B2, B3 and Edge Bin B4 classification 
    trainfeatures = Hist_B2_B3_B4(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = Hist_B2_B3_B4(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHist_B2_B3_B4=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHist_B2_B3_B4(1,i) = CPHist_B2_B3_B4;
    clear trainfeatures testfeatures DM
    
    % Binary Image Bin, Final Bin and Edge Bin Classification
    trainfeatures = Hist_BI_FB_B4(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = Hist_BI_FB_B4(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHist_BI_FB_B4=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHist_BI_FB_B4(1,i) = CPHist_BI_FB_B4;
    clear trainfeatures testfeatures DM
    
    % B3 Texture Bin, Edge Bin and Final Bin Classification
    trainfeatures = Hist_B3_B4_FB(indextrain,:);
    trainlabel = imageDatasetLabel(:,indextrain);
    testfeatures = Hist_B3_B4_FB(indextest,:);
    testlabel = imageDatasetLabel(:,indextest);

    trainNum = size(trainfeatures,1);
    testNum = size(testfeatures,1);
    DM = zeros(testNum,trainNum);
    
    for j=1:testNum
        test = testfeatures(j,:);
        DM(j,:) = distMATChiSquare(trainfeatures,test)';
    end
    % Nearest-neighborhood classifier
    CPHist_B3_B4_FB=ClassifyOnNN(DM,trainlabel,testlabel);
    cp_avgHist_B3_B4_FB(1,i) = CPHist_B3_B4_FB;
    clear trainfeatures testfeatures DM
end

disp('FB - Final Bin Classification');
APHistFB=mean(cp_avgHistFB);
disp(APHistFB);

disp('B1 - Noise Bin Classification');
APHistB1=mean(cp_avgHistB1);
disp(APHistB1);

disp('B2 - Micro Texture Bin Classification');
APHistB2=mean(cp_avgHistB2);
disp(APHistB2);

disp('B3 - Macro Texture Bin Classification');
APHistB3=mean(cp_avgHistB3);
disp(APHistB3);

disp('B4 - Edge Bin Classification');
APHistB4=mean(cp_avgHistB4);
disp(APHistB4);

disp('BI - Binary Image Bin Classification');
APHistBI=mean(cp_avgHistBI);
disp(APHistBI);

disp('FB_B4 - Final Bin with Edge Bin Classification');
APHistFB_B4=mean(cp_avgHistFB_B4);
disp(APHistFB_B4);

disp('BI_B4 - Binary Image Bin with Edge Bin Classification');
APHistBI_B4=mean(cp_avgHistBI_B4);
disp(APHistBI_B4);

disp('FB_BI - Final Bin with Binary Image Bin Classification');
APHistFB_BI=mean(cp_avgHistFB_BI);
disp(APHistFB_BI);

disp('B2_B3 - Micro and Macro Bins Classification');
APHistB2_B3=mean(cp_avgHistB2_B3);
disp(APHistB2_B3);

disp('B2_B3_B4 - Micro and Macro Bins with Edge Bin Classification');
APHist_B2_B3_B4=mean(cp_avgHist_B2_B3_B4);
disp(APHist_B2_B3_B4);

disp('BI_FB_B4 - Binary Image Bin, Final Bin with Edge Bin Classification');
APHist_BI_FB_B4=mean(cp_avgHist_BI_FB_B4);
disp(APHist_BI_FB_B4);

disp('B3_B4_FB - Macro Bin, Edge Bin with Final Bin Classification');
APHist_B3_B4_FB=mean(cp_avgHist_B3_B4_FB);
disp(APHist_B3_B4_FB);

disp(['Total running time is ' num2str(toc/60) ' mins']);






