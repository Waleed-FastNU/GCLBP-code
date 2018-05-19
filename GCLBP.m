function [B1,B2,B3,B4,FB] = GCLBP(img,T1,T2,T3)

[rows,cols] = size(img);

%New Image
GCLBPImg = zeros(cols-2);
binZZ = zeros(cols-2);        % Bin containing noise pixel candidates
binZ1 =  zeros(cols-2);       % Bin containing micro texture pixel candidates
bin1Z = zeros(cols-2);        % Bin containing macro texture pixel candidates
bin11 =  zeros(cols-2);       % Bin containing edges pixel candidates
    
%Looping GCLBP operator
for row = 2:(rows - 1)
    for col = 2:(cols - 1)
    diff1 = abs(double(img(row-1,col-1)) - double(img(row+1,col+1)));
    diff2 = abs(double(img(row-1,col)) - double(img(row+1,col)));
    diff3 = abs(double(img(row-1,col+1)) - double(img(row+1,col-1)));
    diff4 = abs(double(img(row,col+1)) - double(img(row,col-1)));
    
    [bit1,bit2] = thresholdingCheckFP(diff1,T1,T2,T3);[bit3,bit4] = thresholdingCheckFP(diff2,T1,T2,T3);
    [bit5,bit6] = thresholdingCheckFP(diff3,T1,T2,T3);[bit7,bit8] = thresholdingCheckFP(diff4,T1,T2,T3); 
    
    pixDecVal =  bit1*128 + bit2*64 + bit3*32 + bit4*16 + bit5*8 + bit6*4 + bit7*2 + bit8;
    
    GCLBPImg(row-1,col-1) = pixDecVal;
    binZZ(row-1,col-1) = LUT(pixDecVal,T1,T2,T3,pixDecVal,0,0,0);
    binZ1(row-1,col-1) = LUT(pixDecVal,T1,T2,T3,0,pixDecVal,0,0);
    bin1Z(row-1,col-1) = LUT(pixDecVal,T1,T2,T3,0,0,pixDecVal,0);
    bin11(row-1,col-1) = LUT(pixDecVal,T1,T2,T3,0,0,0,pixDecVal);
    end
end

    B1 = binZZ;
    B2 = binZ1;
    B3 = bin1Z;
    B4 = bin11;
    FB = GCLBPImg;
    
end

%Thresolding LUT
function x = LUT(pixVal,T1,T2,T3,a,b,c,d)

if(pixVal < T1)
      x = a;
elseif (T1 <= pixVal && pixVal < T2)
          x = b;
elseif (T2 <= pixVal && pixVal < T3)
              x = c;
elseif(T3 <= pixVal)
      x = d;
end

end

%Thresolding
function [x,y] = thresholdingCheckFP(pixVal,T1,T2,T3)

if(pixVal < T1)
      x = 0; y =0;
elseif (T1 <= pixVal && pixVal < T2)
          x = 0; y = 1;
elseif (T2 <= pixVal && pixVal < T3)
              x = 1; y =0;
elseif(T3 <= pixVal)
      x = 1; y = 1;
end

end
