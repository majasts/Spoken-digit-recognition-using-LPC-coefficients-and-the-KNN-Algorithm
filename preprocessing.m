function [y] = preprocessing(x,fs,last)
    if last==1
        figure()
        plot(0:1/fs:(length(x)-1)/fs,x)
        hold on
        title('Vremenski oblik obradjenog signala')
        xlabel('t[s]')
    end

    Wn = [300 3500]/(fs/2); 
    [B,A] = butter(6,Wn,'bandpass');
    x = filter(B,A,x);
    if last==1
        plot(0:1/fs:(length(x)-1)/fs,x)
        legend('originalni signal', 'filtirani signal')
        hold off 
    end

    wl = 10e-3*fs;
    E = zeros(length(x),1); % KVE
    for i = wl:length(x)
        rng = (i - wl + 1):i-1;
        E(i) = sum(x(rng).^2);
    end
    ITU = 0.1*max(E);
    ITL = 0.0001*max(E);
    voice_index=find(E>ITU);
    y = x(voice_index(1):voice_index(end));
    if last==1

        figure()
        plot(0:1/fs:(length(y)-1)/fs,y)
        title('Vremenski oblik obradjenog signala')
        xlabel('t[s]')
    end
    
end