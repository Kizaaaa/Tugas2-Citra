function g = brighten_frequency(img_path, D0, k)
    I = imread(img_path);
    I_gray = im2double(rgb2gray(I));
    F = fft2(I_gray);
    F_shifted = fftshift(F);
    [M, N] = size(I_gray);
    [u, v] = meshgrid(-floor(N/2):floor(N/2)-1, -floor(M/2):floor(M/2)-1);
    D = sqrt(u.^2 + v.^2);
    H_lowpass = exp(-(D.^2) / (2 * (D0^2)));
    H_highboost = (k - 1) + H_lowpass;
    G = H_highboost .* F_shifted;
    G_ishift = ifftshift(G);
    g = real(ifft2(G_ishift));
    g = mat2gray(g);
    figure;
    subplot(1,2,1); imshow(I_gray); title('Input Image');
    subplot(1,2,2); imshow(g); title('Filtered Image');
end
