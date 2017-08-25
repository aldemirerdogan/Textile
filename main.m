clc;
close all;

% Define constants
% Crop related
crop_size = 512;            % Image crop size

% Rotation Realted
theta_range = 0:180;        % Image rotation angles

% Median filtering related
medfilt1_mask = [3, 3];     % 1st median filter mask
medfilt2_mask = [7, 3];     % 2nd median filter mask

% Anisotrpik filtering related
num_iter = 50;              % Number of iterations
delta_t = 0.01;             % Integration constant. See (anisodiff2D.m)
kappa = .5; % 5             % Gradient modulus threshold. See (anisodiff2D.m)
option = 1;                 % Conduction coefficient functions

% Gabor filter related
wavelength = 10;            % Gabor filter wavelength in pixels
alpha = 0.0005;             % Gabor filter amplitude scaling

% Define image
image = 'IMG_5684.CR2';

% Blocks....
image_gray = image_acquisition(image, crop_size);                           % Image acquisition
image_aniso = anisodiff2D(image_gray, num_iter, delta_t, kappa, option);    % Anisotropic filtering 
theta = find_theta(image_aniso);                                            % Find rotation angle
image_gabor = gabor_filter(image_aniso, theta, wavelength, alpha);          % Gabor filter the image
image_enhanced = contrast_enhancement(image_gabor);                         % Contrast enhancement
image_rotated  = imrotate(image_enhanced, -theta);                          % Rotata the image
image_gray_line_profile = mean(image_rotated);                              % Image gray-line-profiled
number_of_fabric = find_number_of_peaks(image_gray_line_profile);           % Find number of peaks

% Plotting...
figure();
imshow(image_gray);
xlabel('image gray'); 

figure();
imshow(uint8(image_aniso));
xlabel('image aniso'); 

figure();
imshow(uint8(image_gabor));
xlabel('image gabor'); 

figure();
imshow(uint8(image_enhanced))
xlabel('image enhanced'); 

figure();
imshow(uint8(image_rotated))
xlabel('image enhanced'); 

figure();
plot(image_gray_line_profile);
xlabel('image grayline profile'); 
legend(num2str(num_peaks));