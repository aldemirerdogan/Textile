% Data acquisition 
% TODO ism bulal?m, goruntuler islencek 
% introduction için makalelerden derleme ya?lacak 

clear all; clc;
close all;

name = 'IMG_5683.JPG'
choice = 0 % ?f choice is 1, rotate the image

I=imread(name);
image_gray = I;
% figure, imshow(I)
image_gray = rgb2gray(image_gray);
if choice == 1
    image_gray = imrotate(image_gray,90);
end
[r ,c] = size(image_gray);
figure(1); imshow(I(round(r/2-256):round(r/2+256), round(c/2-256):round(c/2+256)))
% dikey plik 

% image_gray =image_gray(round((r/2+10)-250):round(r/2+248),round((c/2)-253):round(c/2+256));
% atk? cozgu ????????


% Anisotropic Diffusion Filtering
  num_iter = 50;
  delta_t = 0.01;
  kappa = .5; % 5
  option = 1;

image_aniso =uint8( anisodiff2D(image_gray, num_iter, delta_t, kappa, option));


theta_range = 0:1:180;
vector_num_peaks = zeros(1,length(theta_range));

for k = 1:length(theta_range)
    image_rot = imrotate(image_aniso, theta_range(k),'bicubic');
    image_rot_cropped = image_rot(round(r/2-256):round(r/2+256), round(c/2-256):round(c/2+256));
    Px = mean(image_rot_cropped);
    [pks1,~]=findpeaks(Px);
    vector_num_peaks(k) = length(pks1);  
end

[min_value, min_index] = min(vector_num_peaks);
theta_min = theta_range(min_index);
theta_rotation = 90-theta_min;

% Gabor Filter with theta angle
% wavelength = 9;
% alpha = 0.0004 ; 
% 

wavelength = 10;
alpha = 0.00025; 
g = gabor(wavelength,theta_rotation);
outMag = imgaborfilt(image_aniso,g);
image_gabor_filtered = alpha *outMag ; 

 % Median filter
% pre-processing with [m,n] where m>n, m \in {12..15} n \in {1 2 3 4}

% mask = [5,3];
% image_median_filtered = medfilt2(image_gabor_filtered,mask);

I = image_gabor_filtered;
if size(I,3)== 3
            P = rgb2gray(uint8(I));
            P = double(P);
elseif size(I,3) == 2
            P = 0.5.*(double(I(:,:,1))+double(I(:,:,2)));
else
            P = double(I);
end
ssize=9;
mg=max(P(:));

f1 = @(x) min(x(:));
m1 = nlfilter(P,[9 9],f1);
f2 = @(x) max(x(:));
m2 = nlfilter(P,[9 9],f2);

image_cont=((P-m1)./(m2-m1)).*mg;

% GRAY LINE PROFIL

image_cont = imrotate(image_cont,-theta_rotation);
image_cont_crop = image_cont(round(r/2-256):round(r/2+256), round(c/2-256):round(c/2+256));
gray_line = mean(image_cont_crop);
% peak_parameter = 0.125;
peak_parameter = 0.025 * max(gray_line);
x = linspace(0, 1, 513);
[number_fabric,~] = findpeaks(gray_line,x,'MinPeakProminence',peak_parameter,'Annotate','extents')
figure(2); imshow((image_cont_crop))

fprintf('\nName of the image: %s\n', name)
fprintf('\nChoice: %d\n', choice)
fprintf('\nNumber of fabric: %d\n', length(number_fabric))
fprintf('\nTheta rotation: %d\n', theta_rotation)
beep on;
beep
