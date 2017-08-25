function output_image = gabor_filter(image, slant, wavelength,  alpha)
    % Filter the image using Gabor filter
    % Inputs:
    %   image(array): Input image 
    %   wavelength(double): Wavelength of Gabor filter in pixels(default=10)
    %   slant(double): Slant angle of image
    %   alpha(double): Amplitude scaling parameter(default=0.0005)
    % Output: 
    %   output_image(array): Gabor filtered image
    
    if nargin < 4 || isempty(alpha)
        alpha = 0.0005;
    end
    if nargin < 3 || isempty(wavelength)
        wavelength = 10;
    end
    
    orientation = slant;        % Slant of the filter
    g = gabor(wavelength,orientation);      % Construct Gabot filter
    output_image = alpha * imgaborfilt(image, g);   % Filter the image with g
end




