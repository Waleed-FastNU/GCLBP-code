close all;clear all;clc
rootpic = 'Outex_TC_00012\';

picNum = 9120; 

P=8;
patternMappingriu2 = getmapping(P,'riu2');
mapping = patternMappingriu2;
bins = mapping.num;

% Threshold Settigs
T1 = 1;    % Edge Threshold
T2 = 11.11;    % Texture Threshold
T3 = 33.11;   % Edge Threshold

tic
for i=1:picNum
    filename = sprintf('%s\\images\\%06d.ras', rootpic, i-1);
    display(['.... ' num2str(i) ])
    Gray = imread(filename);
    Gray = im2double(Gray);
           
    I = (Gray-mean(Gray(:)))/std(Gray(:))*20+128; % normalized to have zero mean and standard deviation  
    BI = im2bw(Gray(2:127, 2:127));
    
    [B1,B2,B3,B4,FB] = GCLBP(I,T1,T2,T3);
    
    sizarray = size(FB);
        
    B1 = B1(:);
    B1 = mapping.table(B1+1);
    B1 = reshape(B1,sizarray);
 
    B2 = B2(:);
    B2 = mapping.table(B2+1);
    B2 = reshape(B2,sizarray);
    
    B3 = B3(:);
    B3 = mapping.table(B3+1);
    B3 = reshape(B3,sizarray);
    
    B4 = B4(:);
    B4 = mapping.table(B4+1);
    B4 = reshape(B4,sizarray);
    
    FB = FB(:);
    FB = mapping.table(FB+1);
    FB = reshape(FB,sizarray);
    
    HistFB(i,:) = hist(FB(:),0:patternMappingriu2.num-1);
    HistB1(i,:) = hist(B1(:),0:patternMappingriu2.num-1);
    HistB2(i,:) = hist(B2(:),0:patternMappingriu2.num-1);
    HistB3(i,:) = hist(B3(:),0:patternMappingriu2.num-1);
    HistB4(i,:) = hist(B4(:),0:patternMappingriu2.num-1);
    HistBI(i,:) = hist(BI(:),0:patternMappingriu2.num-1);
    
    % Generate histogram of HistOp/B4
    HistFB_B4H = [FB(:),B4(:)];
    Hist3D = hist3(HistFB_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
    HistFB_B4(i,:) = reshape(Hist3D,1,numel(Hist3D));
    
    
    % Generate histogram of HistOp/B4
    HistBI_B4H = [BI(:),B4(:)];
    Hist3D = hist3(HistBI_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
    HistBI_B4(i,:) = reshape(Hist3D,1,numel(Hist3D));
    
    
    % Generate histogram of HistOp/B4
    HistFB_BIH = [FB(:),BI(:)];
    Hist3D = hist3(HistFB_BIH,[patternMappingriu2.num,patternMappingriu2.num]);
    HistFB_BI(i,:) = reshape(Hist3D,1,numel(Hist3D));
    
    
    % Generate histogram of HistB2/B3
    HistB2_B3H = [B2(:),B3(:)];
    Hist3D = hist3(HistB2_B3H,[patternMappingriu2.num,patternMappingriu2.num]);
    HistB2_B3(i,:) = reshape(Hist3D,1,numel(Hist3D));
    
    
    % Generate histogram of HistB2/B3
    HistB3_B4H = [B3(:),B4(:)];
    Hist3D = hist3(HistB3_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
    HistB3_B4(i,:) = reshape(Hist3D,1,numel(Hist3D));
    
    
    % Generate histogram of Hist_B2_B3_B4
    Hist_B2_B3_B4(i,:) = [HistB4(i,:),HistB2_B3(i,:)];
 
    Hist_BI_FB_B4(i,:) = [HistBI(i,:),HistFB_B4(i,:)];
        
    Hist_B3_B4_FB(i,:) = [HistFB(i,:),HistB3_B4(i,:)];
    
end

% reading data
trainTxt = sprintf('%s000\\train.txt', rootpic);
testTxt = sprintf('%s000\\test.txt', rootpic);
[trainIDs, trainClassIDs] = ReadOutexTxt(trainTxt);  
[testIDs, testClassIDs] = ReadOutexTxt(testTxt);

disp('B1 - Noise Bin Classification');
AP_B1 = cal_AP(HistB1,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B1);

disp('B2 - Micro Texture Bin Classification');
AP_B2 = cal_AP(HistB2,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B2);

disp('B3 - Macro Texture Bin Classification');
AP_B3 = cal_AP(HistB3,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B3);

disp('B4 - Edge Bin Classification');
AP_B4 = cal_AP(HistB4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B4);

disp('FB - Final Bin Classification');
AP_FB = cal_AP(HistFB,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_FB);

disp('BI - Binary Image Bin Classification');
AP_BI = cal_AP(HistBI,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_BI);

disp('FB_B4 - Final Bin with Edge Bin Classification');
AP_FB_B4 = cal_AP(HistFB_B4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_FB_B4);

disp('BI_B4 - Binary Image Bin with Edge Bin Classification');
AP_BI_B4 = cal_AP(HistBI_B4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_BI_B4);

disp('FB_BI - Final Bin with Binary Image Bin Classification');
AP_FB_BI = cal_AP(HistFB_BI,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_FB_BI);

disp('B2_B3 - Micro Texture Bin with Macro Texture Bin Classification');
AP_B2_B3 = cal_AP(HistB2_B3,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B2_B3);

disp('B3_B4 - Macro Texture Bin with Edge Bin Classification');
AP_B3_B4 = cal_AP(HistB3_B4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B3_B4);

disp('B2_B3_B4 - Micro and Macro Texture Bin with Edge Bin Classification');
AP_B2_B3_B4 = cal_AP(Hist_B2_B3_B4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_B2_B3_B4);

disp('BI_FB_B4 - Binary Image Bin, Final Bin with Edge Bin Classification');
AP_BI_FB_B4 = cal_AP(Hist_BI_FB_B4,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP_BI_FB_B4);

disp('B3_B4_FB - Macro Bin, Edge Bin with Final Bin Classification');
AP = cal_AP(Hist_B3_B4_FB,trainIDs, trainClassIDs,testIDs, testClassIDs);
disp(AP);

display(['Time consuming ' num2str(toc/60) ' mins'])