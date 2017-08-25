clc;
clear all

load woman
image = uint8(X);
theta = 30;
image_rotated = imrotate(image, theta);

[b, a] = size(image);
% [bb, aa] = size(image_rotated);
% bbb = a * sind(theta) + b * cosd(theta);
% aaa = b * sind(theta) + a * cosd(theta);

