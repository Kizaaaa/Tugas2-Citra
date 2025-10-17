function noise_filter_test(img_path)
    I = im2double(imread(img_path));
    if size(I,3)==3
        I_gray = rgb2gray(I);
    else
        I_gray = I;
    end
    I_sp = imnoise(I_gray,'salt & pepper',0.05);
    I_gs = imnoise(I_gray,'gaussian',0,0.01);
    m = 3; n = 3; p = floor(m/2); q = floor(n/2);
    [M,N] = size(I_sp);
    pad = padarray(I_sp,[p q],'replicate');
    min_f = zeros(M,N); max_f = zeros(M,N); median_f = zeros(M,N);
    arith_f = zeros(M,N); geo_f = zeros(M,N); harm_f = zeros(M,N);
    contra_f = zeros(M,N); mid_f = zeros(M,N); alpha_f = zeros(M,N);
    Q = 1.5; alpha = 2;
    for i=1:M
        for j=1:N
            block = pad(i:i+m-1,j:j+n-1);
            blockv = block(:);
            min_f(i,j)=min(blockv);
            max_f(i,j)=max(blockv);
            median_f(i,j)=median(blockv);
            arith_f(i,j)=mean(blockv);
            geo_f(i,j)=exp(mean(log(blockv+eps)));
            harm_f(i,j)=m*n/sum(1./(blockv+eps));
            contra_f(i,j)=sum(blockv.^(Q+1))/sum(blockv.^Q+eps);
            mid_f(i,j)=(min(blockv)+max(blockv))/2;
            sorted=sort(blockv);
            trimmed=sorted(alpha+1:end-alpha);
            alpha_f(i,j)=mean(trimmed);
        end
    end
    figure;
    subplot(3,4,1);imshow(I_gray);title('Original');
    subplot(3,4,2);imshow(I_sp);title('Salt & Pepper');
    subplot(3,4,3);imshow(min_f);title('Min');
    subplot(3,4,4);imshow(max_f);title('Max');
    subplot(3,4,5);imshow(median_f);title('Median');
    subplot(3,4,6);imshow(arith_f);title('Arithmetic');
    subplot(3,4,7);imshow(geo_f);title('Geometric');
    subplot(3,4,8);imshow(harm_f);title('Harmonic');
    subplot(3,4,9);imshow(contra_f);title('Contraharmonic');
    subplot(3,4,10);imshow(mid_f);title('Midpoint');
    subplot(3,4,11);imshow(alpha_f);title('Alpha-trimmed');
    subplot(3,4,12);imshow(I_gs);title('Gaussian Noise');
end
