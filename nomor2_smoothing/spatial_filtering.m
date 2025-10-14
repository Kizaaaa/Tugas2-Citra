function [mean_filtered, gauss_filtered] = spatial_filtering(image, n)
    % Membuat mean filter n x n
    mean_filter = ones(n) / (n^2);

    % Membuat Gaussian filter n x n
    sigma = n / 6; % perkiraan sigma
    [x, y] = meshgrid(-floor(n/2):floor(n/2), -floor(n/2):floor(n/2));
    gauss_filter = exp(-(x.^2 + y.^2) / (2 * sigma^2));
    gauss_filter = gauss_filter / sum(gauss_filter(:));

    % Konvolusi manual
    mean_filtered  = konvolusi_citra(image, mean_filter);
    gauss_filtered = konvolusi_citra(image, gauss_filter);
end
