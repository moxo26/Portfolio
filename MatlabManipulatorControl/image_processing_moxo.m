function [CCx, CCy,CC] = image_processing_moxo()
%% Opens Image
filename = uigetfile({'*.png;*.jpg'})
img = imread(filename);
img = imrotate(img,90);
[row,coloum]= size(img)
%% Prepares Image for Contour Processing
if row >coloum
    asp = 50/round(row/35 )
elseif coloum > row
    asp = 50/round(coloum/35 )
end
img = rgb2gray(img);
img = imresize(img,asp);
img = flip(img,1);
img = imsharpen(img);

%% Finds Contour
figure(1)
[C,H] = imcontour(img,1);

%% Deletes Small Contour Lines and Creates new Data Structure
CC = {};
i = 1;
j = 1;
% Ensures only contours with more than 100 pixels are kept
while (i < size(C,2))
    numPix = C(2,i);
    if numPix >100
        CC{j} = C(:,i+1:i+numPix);
        j = j+1;
    end
    i = i+numPix+1;   
end
% Creates empty structure to hold X and Y Contour Lines
CCx = {};
CCy = {};
% Seperates the CC structure into CCx and CCy structures
for h = 1:size(CC,2)
    %Scales Image
    CCx{h}(1,:) = CC{h}(1,:)./50 +25;
    CCy{h}(1,:) = CC{h}(2,:)./50 -10;
end
close(figure(1))

%% plot image
for h = 1:size(CCx,2)
    for i = 1:5:size(CCx{h},2)
        hold on
%         axis([0 40 -40 40])
        plot(CCx{1,h}(1,i), CCy{1,h}(1,i),'.') 
    end
    
end

