% am132
% Akash Mitra
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100

% Inclass11

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% NOTE: File not located in local Git rep due to large image size.

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.
stem_cell = '011917-wntDose-esi017-RI_f0016.tif';
stem_cell_reader = bfGetReader(stem_cell);

%a - Size in X and Y
sizeX = stem_cell_reader.getSizeX;
sizeY = stem_cell_reader.getSizeY;
disp(['Size of X: ' int2str(sizeX)]);
disp(['Size of Y: ' int2str(sizeY)]);

%b - Number of slices
sliceZ = stem_cell_reader.getSizeZ;
disp(['Number of Slices: ' int2str(sliceZ)]);

%c - Number of time points
timepoints = stem_cell_reader.getSizeT;
disp(['Number of Timepoints: ' int2str(timepoints)]);

%d - Number of Channels
channels = stem_cell_reader.getSizeC;
disp(['Number of Channels: ' int2str(channels)]);

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

% Reading Channel 1
time = 30;
chan = 1;
zplane = sliceZ;
iplane = [];

for i=1:time;
    iplane = stem_cell_reader.getIndex(zplane-1, chan-1, i-1)+1;
end

img = bfGetPlane(stem_cell_reader, iplane);
imshow(img, [500 5000]);

%Reading Channel 2
time2 = 30;
chan2 = 2;
zplane2 = sliceZ;
iplane2 = [];

for i2=1:time2;
    iplane2 = stem_cell_reader.getIndex(zplane2-1, chan2-1, i2-1)+1;
end

img2 = bfGetPlane(stem_cell_reader, iplane2);
imshow(img2, [500 1500]);

% iplane = stem_cell_reader.getIndex(0,0,29)+1;
% img = bfGetPlane(stem_cell_reader, iplane);
% imshow(img, [500 5000]);
% 
% iplane2= stem_cell_reader.getIndex(0,1,29)+1;
% img2 = bfGetPlane(stem_cell_reader, iplane);
% imshow(img2, [500 5000]);

img2show = cat(3, imadjust(img), imadjust(img2), zeros(size(img)));
imshow(img2show);

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

%Find brightest image first
im_bright = (2^16-1)*(img/max(max(img)));
imshow(im_bright, []);

%Convert brightest image to double - Probs not required
img_d = im2double(img);
img_bright = uint16( (2^16-1)*(img_d/max(max(img_d))));
imshow(img_bright);

%Making a series of binary masks

img_bw = img > 1000;
imshow(img_bw);

img_bw = img > 1500;
imshow(img_bw);

img_bw = img > 1775;
imshow(img_bw);

%Optimal threshold achieved with final binary mask, which marks membrane

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

%Define structural element of disk radius 3
structure_el = strel('disk',3);

imshow(img_bw);
%Erosion Mask
imshow(imerode(img_bw, structure_el));
%Erosions compute the minimum of each pixels local neighborhood. As a
%result, the binary mask that was created initially is now represented as a
%complete black image, i.e., the minimum of the pixel neighborhoods.


imshow(img_bw);
%Dilation Mask
imshow(imdilate(img_bw, structure_el));
%Dilations compute the maximum of each pixels local neighborhood. As a
%result, the binary mask that was created initially is now represented
%with a stronger/more dense pixel, i.e. The areas of the image that were 
%brighter, are now even more bright as a result of the the maximum of the pixel
%neighborhoods.


