function g = brighten_frequency(img_path, D0, k)
    % D0: Cutoff frequency
    % Makin kecil D0 cuman low frequency aja yang boleh lewat (soft brigtness, less detail)
    % Makin besar D0 lebih banyak frequency yang mid bisa masuk (lebih
    % tajam dan kontras)

    % k: Boosting factor 
    % k = 1 -> normal low pass filter 
    % k > 1 -> high-boost effect 
    I = imread(img_path);
    I_gray = im2double(rgb2gray(I));
    [M, N] = size(I_gray);
    F = fft2(I_gray);
    F_shifted = fftshift(F);
    [u, v] = meshgrid(-floor(N/2):(ceil(N/2)-1), -floor(M/2):(ceil(M/2)-1));
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
