clc
clear
close all
load('S11_Session1.mat');

%% Separate SSVEP Signals for Each Frequency for ear-EEG

t_class1 = zeros(1, 50);      %class1 related to 10 Hz
t_class2 = zeros(1, 50);      %class2 related to 8.57 Hz
t_class3 = zeros(1, 50);      %class3 related to 7.5 Hz
c = 0;
d = 0;
e = 0;

 % extracting stimuli time and insulating into three separate groups:
for i = 1:150
    if ear_cnt.y_dec(i) == 1
        c = c + 1;
        t_class1(c) = ear_cnt.t(i);
    elseif ear_cnt.y_dec(i) == 2
        d = d + 1;
        t_class2(d) = ear_cnt.t(i); 
    else
        e = e + 1;
        t_class3(e) = ear_cnt.t(i);
    end
end
 %
SSVEP_class1 = zeros(18,50,5000);  % 18 channels, 50 trials, 2sec before flicker + 6sec flicker + 2sec rest = 10 sec >> 10*500 samples
SSVEP_class2 = zeros(18,50,5000);
SSVEP_class3 = zeros(18,50,5000);
for channs = 1:18
    for i=1:50
        SSVEP_class1(channs, i, :) = ear_cnt.x(channs, t_class1(i)-1000:t_class1(i)+3999);
        SSVEP_class2(channs, i, :) = ear_cnt.x(channs, t_class2(i)-1000:t_class2(i)+3999);
        SSVEP_class3(channs, i, :) = ear_cnt.x(channs, t_class3(i)-1000:t_class3(i)+3999);
    end
end

%% plot single example of SSVEP
ssvep = reshape(SSVEP_class1(1,1,:), [1 size(SSVEP_class1,3)]);
plot(ssvep)
title('SSVEP Signal related to the First channel and First stimulus')