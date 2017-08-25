function num_peaks = find_number_of_peaks(gray_line_profile)
    % Finds the number of peaks
    % Input(array): Gray line profile of an image
    % Output(integer): Number of peaks in gray_line_profile 
    [number_fabric, ~]=findpeaks(gray_line_profile);    % Find number of peaks
    num_peaks = length(number_fabric);      % Number of fabric
end