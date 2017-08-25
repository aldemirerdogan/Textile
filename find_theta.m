function theta = find_theta(image, theta_range)
    % Finds the rotation angle of the image by taking gray_line_profile
    % of the image for all theta in theta_range
    % Inputs:
    %   image(array): Input image
    %   theta_range(array): Range of angles to be scanned
    % Output:
    %   theta_rotation(double): Rotation angle = -image_angle
    
    if nargin < 2 || isempty(theta_range)
       theta_range = 0 : 180;
    end
    
    num_peaks = zeros(1, length(theta_range));
    for k = 1:length(theta_range)
        image_rot = imrotate(image, theta_range(k));    % Roate the image
        image_profile = mean(image_rot);                % Take gray-line-profile
        [pks,~]=findpeaks(image_profile);               % Find the peaks
        num_peaks(k) = length(pks);                     % Count number of paeaks
    end
    
    [~, min_index] = min(num_peaks);    % Take min index of num_peaks  
    theta = theta_range(min_index); % Find rotation of the image
    % theta_rotation = -theta_min;        % Return rotation angle
end
