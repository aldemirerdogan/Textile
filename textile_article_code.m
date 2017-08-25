% Data acquisition 
% TODO ism bulal?m, goruntuler islencek 
% introduction için makalelerden derleme ya?lacak 




clear all; clc;
close all;
I=imread('IMG_5684.CR2');

% image_raw =imread('IMG_5675.JPG');
image_gray = I;
% figure, imshow(I)
image_gray = rgb2gray(image_gray);

% dikey plik 
[r ,c] = size(image_gray);
image_gray =image_gray(round((r/2+10)-250):round(r/2+248),round((c/2)-253):round(c/2+256));

%image_gray = imrotate(image_gray,90);


%image_gray = image_gray(1:end/2, 1:end/2);
figure, imshow(image_gray)

% % Anisotropic Diffusion Filtering
%   num_iter = 50;
%   delta_t = 0.01;
%   kappa = .5; % 5
%   option = 1;
% 
% image_aniso = anisodiff2D(image_gray, num_iter, delta_t, kappa, option);

% subplot(1,2,1),imshow(image_gray);
% subplot(1,2,2),imshow(uint8(image_aniso));

% scan theta range 0 - pi to determine angle
image_aniso = image_gray;

theta_range = 0:1:180;
vector_num_peaks = zeros(1,length(theta_range));
for k = 1:length(theta_range)
    image_rot = imrotate(image_aniso, theta_range(k));
 
    for j=1:size(image_rot,2)
      for i=1:size(image_rot,1)
        P1(i)=image_rot(i,j);
      end
      Px(j)=sum(P1)/size(image_rot,1);
    end
    % figure(k);  findpeaks(Px);
    [pks1,~]=findpeaks(Px);
    
    vector_num_peaks(k) = length(pks1);  
end

[min_value, min_index] = min(vector_num_peaks);
theta_min = theta_range(min_index);
theta_rotation = 90 - theta_min;

% Gabor Filter with theta angle
% wavelength = 9;
% alpha = 0.0004 ; 
% 
wavelength = 10;
alpha = 0.0005; 
orientation = theta_rotation;
g = gabor(wavelength,orientation);
outMag = imgaborfilt(image_aniso,g);
image_gabor_filtered = alpha *outMag ; 
subplot(1,2,1),imshow(uint8(image_aniso));
subplot(1,2,2),imshow(image_gabor_filtered);

 % Median filter
% pre-processing with [m,n] where m>n, m \in {12..15} n \in {1 2 3 4}

% mask = [5,3];
% image_median_filtered = medfilt2(image_gabor_filtered,mask);
% subplot(1,2,1),imshow(image_gabor_filtered)
% subplot(1,2,2),imshow(image_median_filtered)

 
 %
% %  LEN = 10;
% % THETA = 11;
% % PSF = fspecial('motion', LEN, THETA);
% % blurred = imfilter(image_gabor_filtered, PSF, 'conv', 'circular');
% % imshow(blurred);
% % title('Blurred Image');
% %  wnr1 = deconvwnr(blurred, PSF, 0);
% % imshow(wnr1);
% % title('Restored Image');
% imshow(image_gabor_filtered)
% imcontrast(gca)


I = imresize(image_gabor_filtered,[128 128]);
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
subplot(2,1,1),imshow(P);
subplot(2,1,2),imshow(image_cont);


% %%
% 
%  
%  bw = imbinarize(P_op);
% bw = bwareaopen(bw, 25);
% imshow(bw)
%  
%  
%  pout_imadjust = imadjust(image_gabor_filtered);
% pout_histeq = histeq(image_gabor_filtered);
% pout_adapthisteq = adapthisteq(image_gabor_filtered);
% 
% imshow(image_gabor_filtered);
% title('Original');
% figure, imshow(pout_histeq);
% title('Imadjust');

% GRAY LINE PROFIL

gray_line = mean(image_cont');

[number_fabric,~]=findpeaks(gray_line);
    
vector_num_peaks(k) = length(number_fabric);  











%% Median filter
% pre-processing with [m,n] where m>n, m \in {12..15} n \in {1 2 3 4}
mask = [17,3];
image_median_filtered = medfilt2(image_gray,mask);
subplot(1,2,1),imshow(image_median_filtered)
subplot(1,2,2),imshow(image_gray)


%%

clearvars -except G

G = ans;

for j=1:size(G,2)
  for i=1:size(G,1)
    P1(i)=G(i,j);
  end
  Px(j)=sum(P1)/size(G,1);
end

[pks1,locs1]=findpeaks(Px);
figure, plot(Px)
findpeaks(Px);
text(locs1+.02,pks1,num2str((1:numel(pks1))'))
Result_warp=length(pks1)
%%

for j=1:size(G,1)
  for i=1:size(G,2)
    P2(i)=G(j,i);
  end
  Py(j)=sum(P2)/size(G,2);
end

[pks2,locs2]=findpeaks(Py);
figure, plot(Py)
findpeaks(Py);
text(locs2+.02,pks2,num2str((1:numel(pks2))'))
Result_weft=length(pks2)