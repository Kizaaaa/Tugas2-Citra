function [I_restored, I_blur] = wiener_motion_blur(I, len, theta, K)
    if size(I,3) == 3
        I_blur = zeros(size(I));
        I_restored = zeros(size(I));
        PSF = fspecial('motion', len, theta);
        for c = 1:3
            I_blur(:,:,c) = imfilter(I(:,:,c), PSF, 'conv', 'circular');
            H = psf2otf(PSF, size(I(:,:,c)));
            G = fft2(I_blur(:,:,c));
            F_est = conj(H) ./ (abs(H).^2 + K) .* G;
            I_restored(:,:,c) = real(ifft2(F_est));
        end
    else
        PSF = fspecial('motion', len, theta);
        I_blur = imfilter(I, PSF, 'conv', 'circular');
        H = psf2otf(PSF, size(I));
        G = fft2(I_blur);
        F_est = conj(H) ./ (abs(H).^2 + K) .* G;
        I_restored = real(ifft2(F_est));
    end
end
