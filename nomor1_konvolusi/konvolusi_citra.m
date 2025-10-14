function output = konvolusi_citra(image, mask)
    mask = double(mask);
    mask = mask / sum(mask(:));  % normalisasi 

    % Ukuran mask
    [m, n] = size(mask);
    pad_h = floor(m/2);
    pad_w = floor(n/2);

    image = double(image);
    if ismatrix(image)
        padded = padarray(image, [pad_h pad_w], 'replicate');
        [M, N] = size(image);
        output = zeros(M, N);
        for i = 1:M
            for j = 1:N
                region = padded(i:i+m-1, j:j+n-1);
                output(i, j) = sum(sum(region .* mask));
            end
        end

    elseif ndims(image) == 3
        [M, N, C] = size(image);
        output = zeros(M, N, C);
        for c = 1:C
            channel = image(:,:,c);
            padded = padarray(channel, [pad_h pad_w], 'replicate');
            for i = 1:M
                for j = 1:N
                    region = padded(i:i+m-1, j:j+n-1);
                    output(i, j, c) = sum(sum(region .* mask));
                end
            end
        end
    end

    output = uint8(output);
end
