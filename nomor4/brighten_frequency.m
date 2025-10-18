function g = brighten_frequency(I, D0, k)
    % I: input image (RGB or grayscale)
    % D0: Cutoff frequency
    % k: Boosting factor
    %
    % Performs frequency-domain high-boost filtering
    % while preserving the color of the original image.

    I = im2double(I);
    [M, N, C] = size(I);

    [u, v] = meshgrid(-floor(N/2):(ceil(N/2)-1), -floor(M/2):(ceil(M/2)-1));
    D = sqrt(u.^2 + v.^2);
    H_lowpass = exp(-(D.^2) / (2 * (D0^2)));
    H_highboost = (k - 1) + H_lowpass;

    g = zeros(size(I));

    if C == 3
        for c = 1:3
            F = fft2(I(:,:,c));
            F_shifted = fftshift(F);
            G = H_highboost .* F_shifted;
            G_ishift = ifftshift(G);
            g(:,:,c) = real(ifft2(G_ishift));
        end
    else
        F = fft2(I);
        F_shifted = fftshift(F);
        G = H_highboost .* F_shifted;
        G_ishift = ifftshift(G);
        g = real(ifft2(G_ishift));
    end

    g = mat2gray(g);
end
