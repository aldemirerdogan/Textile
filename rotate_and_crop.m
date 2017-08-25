clear all
load woman;
[b, a] = size(X);

phi  = 2;
%a = a + (b*sind(phi));


a_1x = round((b * sind(phi))/2);
a_1y =  round(a * sind(phi) + (b * cosd(phi))/2);

b_1x =  round( (a * cosd(phi))/2);
b_1y =  round( (a * sind(phi))/2);

a_2x =  round((a * cosd(phi)) + (b * sind(phi)) / 2) ;
a_2y =  round((b * cosd(phi))/2);

b_2x =  round((b * sind(phi)) + (a * cosd(phi))/2);
b_2y =  round(b * cosd(phi) + (a * sind(phi))/2);

X_r = imrotate(X,phi);

x_indices = sort([a_1x, b_1x, a_2x, b_2x]);
y_indices = sort([a_1y, b_1y, a_2y, b_2y]);
x1_index = x_indices(2);
x2_index = x_indices(3);
y1_index = y_indices(2);
y2_index = y_indices(3);
image_cropped = X_r(x1_index : x2_index, y1_index : y2_index);

imshow(uint8(X))
figure();
imshow(uint8(X_r));
figure();
imshow(uint8(image_cropped))





