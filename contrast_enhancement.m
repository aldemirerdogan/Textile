function output_image = contrast_enhancement(image)
    % Contrast enhancement of the image
    % Input:
    %   image(array): Input image
    % Output:
    %   output_image(array): Contrast enhanced image
    image = double(image);  % Convet image to double
    mg = max(image(:));     % Find max of the image

    f1 = @(x) min(x(:));                % Define min function
    m1 = nlfilter(image, [9 9], f1);    % Find min of [9 9] sub-array
    f2 = @(x) max(x(:));                % Define max function
    m2 = nlfilter(image, [9 9], f2);    % Find max of [9 9] sub-array

    output_image = ((image - m1) ./ (m2 - m1)) .* mg;  % Contrast operation
end