clear; clc; close all;

% ==== Input citra ====
% Contoh 1: Grayscale
img_gray = rgb2gray(imread('../Test/image3.jpg'));

% Contoh 2: Warna
img_color = imread('../Test/image6.jpg');

% ==== Buat mask (contoh n=3) ====
mask = [1 1 1; 1 1 1; 1 1 1];  % blur
mask = mask / sum(mask(:));

% ==== Konvolusi manual ====
out_gray_custom = konvolusi_citra(img_gray, mask);
out_color_custom = konvolusi_citra(img_color, mask);

% ==== Konvolusi dengan fungsi Matlab untuk pembanding ====
out_gray_matlab = uint8(conv2(double(img_gray), double(mask), 'same'));
out_color_matlab = img_color;
for c = 1:3
    out_color_matlab(:,:,c) = uint8(conv2(double(img_color(:,:,c)), double(mask), 'same'));
end

% ==== Tampilkan hasil ====
figure;
subplot(2,3,1); imshow(img_gray); title('Grayscale Original');
subplot(2,3,2); imshow(out_gray_custom); title('Custom Convolution');
subplot(2,3,3); imshow(out_gray_matlab); title('MATLAB conv2');

subplot(2,3,4); imshow(img_color); title('Color Original');
subplot(2,3,5); imshow(out_color_custom); title('Custom Convolution');
subplot(2,3,6); imshow(out_color_matlab); title('MATLAB conv2');
