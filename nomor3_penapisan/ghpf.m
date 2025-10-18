function G2 = ghpf(image, D0)
    [M,N] = size(image);

    % Step 1: Tentukan parameter padding, biasanya untuk citra f(x,y)
    % berukuran M x N, parameter padding P dan Q biasanya P = 2M and Q = 2N.
    P = 2*M;
    Q = 2*N;

    % Step 2: Bentuklah citra padding fp(x,y) berukuran P X Q dengan
    % menambahkan pixel-pixel bernilai nol pada f(x, y).
    image = im2double(image);
    for i = 1:P
         for j = 1:Q
             if i <= M && j<= N
                imagep(i,j) = image(i,j);
             else
                imagep(i,j) = 0;
             end
         end
    end

    % Step 3: Lakukan transformasi Fourier pada fp(x, y) dan tampilkan Fourier Spectrum
    F = fftshift(fft2(imagep)); % move the origin of the transform to the center of the frequency rectangle
    
    % Step 4: Bangkitkan fungsi penapis H berukuran P x Q
    % Penapis yang digunakan adalah Gaussian High-pass Filter (GHPF)
    % Set up range of variables.
    u = 0:(P-1);
    v = 0:(Q-1);
    % Compute the indices for use in meshgrid
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;

    % Compute the meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);
    H = exp(-(D.^2)./(2*(D0^2)));
    H = 1 - H;
    H = fftshift(H);

    % Step 5: Kalikan F dengan H
    G = H.*F;
    G1 = ifftshift(G);

    % Step 6: Ambil bagian real dari inverse FFT of G:
    G2 = real(ifft2(G1)); % apply the inverse, discrete Fourier transform

    %Step 7: Potong bagian kiri atas sehingga menjadi berukuran citra semula
    G2 = G2(1:M, 1:N); % Resize the image to undo padding
    %figure, imshow(G2); title('output image');
end
