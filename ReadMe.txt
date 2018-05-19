=====================================
        How to use the code
=====================================
Running Environment: Windows 7,10, Matlab R2013a,R2016a

-----------------------------------------------------
Reproduce the experimental results for Outex_TC_00010
1. Download the Outex_TC_00010 dataset from http://www.outex.oulu.fi/index.php?page=classification
   In the downloaded file 'Outex_TC_00010', the sub-file 'images' includes all the training and test images, and the sub-file '000' incudes the documents specifying the split of the training and test sets. 
2. Run demo_TC10.m to reproduce the reported results.
   --ReadOutexTxt.m: obtain image IDs and class IDs for the Outex dataset.
   --cal_AP.m: texture classification using the nearest-neighborhood (NN) classifier.
      ----distMATChiSquare.m: compute the chi-square distance between the training and test samples.
      ----ClassifyOnNN.m: compute the classification accuracy using the NN classifier.

-----------------------------------------------------
Reproduce the experimental results for Outex_TC_00012
1. Download the Outex_TC_00012 dataset from http://www.outex.oulu.fi/index.php?page=classification
   In the downloaded file 'Outex_TC_00012', the sub-file 'images' includes all the training and test images for TC12t and TC12h. The sub-file '000' incudes the documents specifying the split of the training and test sets for TC12t; the sub-file '001' incudes the documents specifying the split of the training and test sets for TC12h. 
2. Run demo_TC12t.m and demo_TC12h.m to reproduce the reported results.

--------------------------------------------
Reproduce the experimental results for CURET
1. Download the CURET dataset from http://www.robots.ox.ac.uk/~vgg/research/texclass/index.html
2. Store 61 classes of texture images (each class corresponds to one sub-file, e.g., 'sample01' and 'sample02') in a root file 'CURET'. 
3. Run demo_CURET.m to reproduce the reported results.
   --calculate_GCLBP_bins: calculate the GCLBP bins of all images.
   --the code in the loop 'for i = 1: trail': perform N=trail random splits of the training and test sets and compute the classification accuracy with each split. 
   --AP=mean(cp_avg): compute the average accuracy over N=trail random splits.

--------------------------------------------
This code implements functions from CLBP and LETRIST demo codes.
