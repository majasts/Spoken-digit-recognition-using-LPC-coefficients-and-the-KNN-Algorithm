function [msg] = cifer_recognition()
clc
clear 
close all

fs = 8000; 
Ts = 1/fs;
nchans = 1;  
nbits = 16;   
duration = 2; 
N = duration*fs;

% for i=1:5
%     x = audiorecorder(fs, nbits, nchans); %pravimo objekat za snimanje
%     disp('start speaking1');
%     recordblocking(x,duration); %ovom naredom snimamo
%     disp('end of recording');
%     y = getaudiodata(x); %ovako cuvamo samo zvuk u y
%     name=['testjedan',num2str(i),'.wav'];
%     audiowrite(name,y,fs,0);
%     pause()
% end
% for i=1:5
%     x = audiorecorder(fs, nbits, nchans); %pravimo objekat za snimanje
%     disp('start speaking2');
%     recordblocking(x,duration); %ovom naredom snimamo
%     disp('end of recording');
%     y = getaudiodata(x); %ovako cuvamo samo zvuk u y
%     name=['testdva',num2str(i),'.wav'];
%     audiowrite(name,y,fs,0);
%     pause()
% end
% for i=1:5
%     x = audiorecorder(fs, nbits, nchans); %pravimo objekat za snimanje
%     disp('start speaking3');
%     recordblocking(x,duration); %ovom naredom snimamo
%     disp('end of recording');
%     y = getaudiodata(x); %ovako cuvamo samo zvuk u y
%     name=['testtri',num2str(i),'.wav'];
%     audiowrite(name,y,fs,0);
%     pause()
% end
%%
coeffs=[];
labels=[];
for i=1:10
    name=['jedan',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs=[coeffs; coeff];
    labels=[labels; 1];
    % sound(y)
    % pause()
end
for i=1:10
    name=['dva',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs=[coeffs; coeff];
    labels=[labels; 2];
    % sound(y)
    % pause()
end

for i=1:10
    name=['tri',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs=[coeffs; coeff];
    labels=[labels; 3];
    % sound(y)
    % pause()
end
coeffs_train=coeffs;
labels_train=labels;

%
coeffs_test=[];
labels_test=[];
for i=1:5
    name=['testjedan',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs_test=[coeffs_test; coeff];
    labels_test=[labels_test; 1];
    % sound(y)
    % pause()
end

for i=1:5
    name=['testdva',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs_test=[coeffs_test; coeff];
    labels_test=[labels_test; 2];
    % sound(y)
    % pause()
end

for i=1:5
    name=['testtri',num2str(i),'.wav'];
    [x, fs] = audioread(name);
    y=preprocessing(x,fs,0);
    coeff = feature_extraction(y,fs,0);
    coeffs_test=[coeffs_test; coeff];
    labels_test=[labels_test; 3];
    % sound(y)
    % pause()
end
%%
k=5;
knnModel = fitcknn(coeffs_train, labels_train, 'NumNeighbors',k);
predicted_labels_train = predict(knnModel, coeffs_train);
figure()
cm = confusionchart(labels_train, predicted_labels_train);
cm.Title='Konfuziona matrica na trening skupu';

predicted_labels = predict(knnModel, coeffs_test);
for i=1:length(predicted_labels)
    msg=['real: ',num2str(labels_test(i)), ' predicted: ',num2str(predicted_labels(i))];
    %disp(msg)
end
accuracy = sum(predicted_labels == labels_test) / numel(labels_test);
fprintf('Accuracy on test set: %.2f%% \n', accuracy*100)
figure()
cm_test = confusionchart(labels_test, predicted_labels);
cm_test.Title='Konfuziona matrica na test skupu';

x = audiorecorder(fs, nbits, nchans); %pravimo objekat za snimanje
disp('start speaking');
recordblocking(x,duration+2); %ovom naredom snimamo
disp('end of recording');
x = getaudiodata(x); %ovako cuvamo samo zvuk u y
y=preprocessing(x,fs,1);
coeff_new = feature_extraction(y,fs,1);

new_label=predict(knnModel, coeff_new);
msg=['predicted: ', num2str(new_label)];
end

