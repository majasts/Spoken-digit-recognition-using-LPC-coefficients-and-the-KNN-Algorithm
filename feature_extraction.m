function [feature] = feature_extraction(x,fs, last)
    win = round(length(x)/30);
    p = 14; 
    num = round(length(x)/win);
    LPC = zeros(p+1, num); 
    k = 1;
    recon = [];
    for i = 1:win:(length(x)-win)
        [a, s] = arcov(x(i:i+win-1), p);
        LPC(:, k) = a;
        recon = [recon, filter(1, a, randn(1, win)*sqrt(s))];
        k = k + 1;
    end
    s=size(LPC);
    
    % for j=1:s(2)
    %     figure()
    %     stem(LPC(:,j))
    % end

    feature = [mean(LPC,1) std(LPC,0,1)];
    % feature = mean(LPC,1);
    if last==1
        figure()
        subplot(2,1,1)
        stem(mean(LPC,1))
        title('Srednja vrednost 15 LPC koefijenata kroz prozore')
        subplot(2,1,2)
        stem(std(LPC,0,1))
        title('Standardna devijacija 15 LPC koefijenata kroz prozore')
    end
end