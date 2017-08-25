function output_image = image_acquisition(input_image, crop_size)
    % Reads image, converts it to gray level and crops it.
    % Inputs:
    %   input_image_name(string): Input image
    %   crop_size(int): Cropping size
    % Outputs:
    %   output_image(array) = Gray-level image cropped to crop_size
    
    if nargin < 2 || isempty(crop_size)
       crop_size = 512;
    end
   
    image = imread(input_image);        % Read the image
    image_gray = rgb2gray(image);            % Convert image to grat level
    [row, col] = size(image_gray);           % Get image size
    image_gray = image_gray(round(row / 2 - crop_size / 2 : row / 2 + crop_size / 2),...
              round(col / 2 - crop_size / 2 : col / 2 + crop_size / 2));
    output_image = image_gray;                % Return output image
end
