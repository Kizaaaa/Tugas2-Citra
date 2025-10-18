I = imread('3.png'); % Baca citra
% Convert to grayscale if RGB
if size(I, 3) == 3
    I = rgb2gray(I);
end
figure, imshow(I);
title('Original Image');
% Terapkan Fourier Transform
F = fft2(double(I));
F1 = fftshift(F); % Pusatkan FFT
% Tampilkan magnitute spektrum Fourier
F2 = F1;
F2 = abs(F2); % Get the magnitude
F2 = log(F2+1); % Use log
figure, imagesc(100*F2); colormap(gray);
title('magnitude spectrum');

% Buang frekuensi yang mengganggu, set jadi 0

F1(286,270) = 0;
F1(286,302) = 0;

%Kembalikan ke ranah spasial
J = real(ifft2(ifftshift(F1)));

% Normalize to [0, 255] range
J = uint8(mat2gray(J) * 255);

figure, imshow(J);
title('Processed Image');
