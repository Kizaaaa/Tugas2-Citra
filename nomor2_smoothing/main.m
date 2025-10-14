clear; clc; close all;

% === citra ===
img_gray  = rgb2gray(imread('../Test/image17.jpg'));
img_color = imread('../Test/image6.jpg');

% === PARAMETER ===
n = 10;    % ukuran filter spasial
D0 = 30;  % cutoff frequency

% === RANAH SPASIAL ===
[mean_gray, gauss_gray]   = spatial_filtering(img_gray, n);
[mean_color, gauss_color] = spatial_filtering(img_color, n);

% === RANAH FREKUENSI (gunakan grayscale) ===
[ilpf_img, glpf_img, blpf_img] = frequency_filtering(img_gray, D0);

% === TAMPILKAN HASIL ===
figure('Name','Smoothing - Spatial Domain');
subplot(2,3,1); imshow(img_gray); title('Original Grayscale');
subplot(2,3,2); imshow(mean_gray); title('Mean Filter');
subplot(2,3,3); imshow(gauss_gray); title('Gaussian Filter');
subplot(2,3,4); imshow(img_color); title('Original Color');
subplot(2,3,5); imshow(mean_color); title('Mean Filter (Color)');
subplot(2,3,6); imshow(gauss_color); title('Gaussian Filter (Color)');

figure('Name','Smoothing - Frequency Domain');
subplot(2,2,1); imshow(img_gray); title('Original');
subplot(2,2,2); imshow(ilpf_img); title('ILPF');
subplot(2,2,3); imshow(glpf_img); title('GLPF');
subplot(2,2,4); imshow(blpf_img); title('BLPF');
