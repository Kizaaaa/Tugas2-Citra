function [ilpf_img, glpf_img, blpf_img] = frequency_filtering(image, D0)
    % Konversi ke double dan ke grayscale jika perlu
    if ndims(image) == 3
        gray = rgb2gray(image);
    else
        gray = image;
    end
    gray = double(gray);

    [M, N] = size(gray);
    [u, v] = meshgrid(0:N-1, 0:M-1);
    D = sqrt((u - N/2).^2 + (v - M/2).^2);

    % Filter di domain frekuensi
    H_ilpf = double(D <= D0);  % Ideal Low Pass Filter
    H_glpf = exp(-(D.^2) / (2 * (D0^2)));  % Gaussian LPF
    n = 2;  % orde Butterworth
    H_blpf = 1 ./ (1 + (D./D0).^(2*n));  % Butterworth LPF

    % FFT citra
    F = fftshift(fft2(gray));

    % Terapkan filter
    G_ilpf = F .* H_ilpf;
    G_glpf = F .* H_glpf;
    G_blpf = F .* H_blpf;

    % Transformasi balik
    ilpf_img = uint8(real(ifft2(ifftshift(G_ilpf))));
    glpf_img = uint8(real(ifft2(ifftshift(G_glpf))));
    blpf_img = uint8(real(ifft2(ifftshift(G_blpf))));
end
