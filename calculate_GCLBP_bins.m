function [HistFB,HistB1,HistB2,HistB3,HistB4,HistBI,HistFB_B4,HistBI_B4,HistFB_BI,HistB2_B3,Hist_B2_B3_B4,Hist_BI_FB_B4,Hist_B3_B4_FB] = ...
calculate_GCLBP_bins(rt_img_dir, imtype)

subfolders = dir(rt_img_dir);
database = [];

database.imnum = 0; % total image number of the database
database.cname = {}; % name of each class
database.label = []; % label of each class
database.path = {}; % contain the pathes for each image of each class
database.nclass = 0;

P=8;
patternMappingriu2 = getmapping(P,'riu2');
mapping = patternMappingriu2;

% Threshold Settigs
T1 = 15;    % Edge Threshold
T2 = 25;    % Texture Threshold
T3 = 40;   % Edge Threshold

w=0;
for ii = 1:length(subfolders),
    subname = subfolders(ii).name;    
    if ~strcmp(subname, '.') && ~strcmp(subname, '..'),
        database.nclass = database.nclass + 1;        
        database.cname{database.nclass} = subname;        
        frames = dir(fullfile(rt_img_dir, subname, ['*.' imtype]));
        
        c_num = length(frames);           
        database.imnum = database.imnum + c_num;
        database.label = [database.label; ones(c_num, 1)*database.nclass];
                
        for jj = 1:c_num,
            imgpath = fullfile(rt_img_dir, subname, frames(jj).name);            
            I = imread(imgpath);
            if ndims(I) == 3,
                I = im2double(rgb2gray(I)); 
            else
                I = im2double(I);
            end;
            
            w = w+1;
            
            I = (I-mean(I(:)))/std(I(:))*20+128; % normalized to have zero mean and standard deviation  
            BI = im2bw(I(2:199, 2:199));
            
            disp(['__' imgpath]);
           
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
    
            HistFB(w,:) = hist(FB(:),0:patternMappingriu2.num-1);
            HistB1(w,:) = hist(B1(:),0:patternMappingriu2.num-1);
            HistB2(w,:) = hist(B2(:),0:patternMappingriu2.num-1);
            HistB3(w,:) = hist(B3(:),0:patternMappingriu2.num-1);
            HistB4(w,:) = hist(B4(:),0:patternMappingriu2.num-1);
            HistBI(w,:) = hist(BI(:),0:patternMappingriu2.num-1);

            % Generate histogram of HistOp/B4
            HistFB_B4H = [FB(:),B4(:)];
            Hist3D = hist3(HistFB_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
            HistFB_B4(w,:) = reshape(Hist3D,1,numel(Hist3D));

            % Generate histogram of HistOp/B4
            HistBI_B4H = [BI(:),B4(:)];
            Hist3D = hist3(HistBI_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
            HistBI_B4(w,:) = reshape(Hist3D,1,numel(Hist3D));

            % Generate histogram of HistOp/B4
            HistFB_BIH = [FB(:),BI(:)];
            Hist3D = hist3(HistFB_BIH,[patternMappingriu2.num,patternMappingriu2.num]);
            HistFB_BI(w,:) = reshape(Hist3D,1,numel(Hist3D));

            % Generate histogram of HistB2/B3
            HistB2_B3H = [B2(:),B3(:)];
            Hist3D = hist3(HistB2_B3H,[patternMappingriu2.num,patternMappingriu2.num]);
            HistB2_B3(w,:) = reshape(Hist3D,1,numel(Hist3D));

            % Generate histogram of HistB2/B3
            HistB3_B4H = [B3(:),B4(:)];
            Hist3D = hist3(HistB3_B4H,[patternMappingriu2.num,patternMappingriu2.num]);
            HistB3_B4(w,:) = reshape(Hist3D,1,numel(Hist3D));

            % Generate histogram of Hist_B2_B3_B4
            Hist_B2_B3_B4(w,:) = [HistB4(w,:),HistB2_B3(w,:)];

            Hist_BI_FB_B4(w,:) = [HistBI(w,:),HistFB_B4(w,:)];

            Hist_B3_B4_FB(w,:) = [HistFB(w,:),HistB3_B4(w,:)];

        end;    
    end;
end; 

