function [mean_filtered, gauss_filtered] = spatial_filtering(image, n)
    % spatial_filtering - Applies mean and Gaussian filters of size n×n
    % Input: image (RGB or grayscale), n (filter size)
    % Output: mean_filtered, gauss_filtered

    mean_filter = ones(n) / (n^2);

    sigma = n / 6;
    [x, y] = meshgrid(-floor(n/2):floor(n/2), -floor(n/2):floor(n/2));
    gauss_filter = exp(-(x.^2 + y.^2) / (2 * sigma^2));
    gauss_filter = gauss_filter / sum(gauss_filter(:));

    mean_filtered  = konvolusi_citra(image, mean_filter);
    gauss_filtered = konvolusi_citra(image, gauss_filter);
end
