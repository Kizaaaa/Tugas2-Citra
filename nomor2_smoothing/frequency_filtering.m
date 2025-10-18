function [ilpf_img, glpf_img, blpf_img] = frequency_filtering(image, D0)
    % frequency_filtering - Apply ILPF, GLPF, and BLPF filters
    % Input:  image (RGB or grayscale)
    %         D0 (cutoff frequency)
    % Output: ilpf_img, glpf_img, blpf_img (uint8)

    if ischar(image) || isstring(image)
        image = imread(image);
    end
    image = im2double(image);
    [M, N, C] = size(image);

    [u, v] = meshgrid(0:N-1, 0:M-1);
    D = sqrt((u - N/2).^2 + (v - M/2).^2);

    % Frequency response definitions
    H_ilpf = double(D <= D0);
    H_glpf = exp(-(D.^2) / (2 * (D0^2)));
    n = 2;
    H_blpf = 1 ./ (1 + (D./D0).^(2*n));

    % Initialize output
    ilpf_img = zeros(M, N, C);
    glpf_img = zeros(M, N, C);
    blpf_img = zeros(M, N, C);

    % Apply filters per channel
    for c = 1:C
        F = fftshift(fft2(image(:,:,c)));
        G_ilpf = F .* H_ilpf;
        G_glpf = F .* H_glpf;
        G_blpf = F .* H_blpf;

        ilpf_img(:,:,c) = real(ifft2(ifftshift(G_ilpf)));
        glpf_img(:,:,c) = real(ifft2(ifftshift(G_glpf)));
        blpf_img(:,:,c) = real(ifft2(ifftshift(G_blpf)));
    end

    % Normalize and convert to uint8
    ilpf_img = im2uint8(mat2gray(ilpf_img));
    glpf_img = im2uint8(mat2gray(glpf_img));
    blpf_img = im2uint8(mat2gray(blpf_img));
end
