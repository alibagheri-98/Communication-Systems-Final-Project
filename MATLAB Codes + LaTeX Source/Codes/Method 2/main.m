%% DSB part b and d
clear;clc;
T = 300;
K = 1.38e-23;
N0 = K*T;
Ac = 1;
fc = 400000;
num = 100;
t=0:0.05:20;
WW = linspace(0.1,10,num);
snr_dsb_dB = linspace(5,5000,num);
for i = 1:num
    W = WW(i);
    msg = cos(2*pi*W*t);
    mod = dsb_modulator(msg, t, W, fc, Ac);
    chn = channel(mod, t, W, 0);
    demod = dsb_demodulator(chn, t, W, fc);
    signal = demod;
    s_pow = mean(demod.^2);
    mod = dsb_modulator(msg, t, W, fc, Ac);
    chn = channel(mod, t, W, N0);
    demod = dsb_demodulator(chn, t, W, fc);
    noisySignal = demod;
    noise = noisySignal - signal;
    n_pow = mean(noise.^2);
    snr_dsb = (s_pow / n_pow);
    snr_dsb_dB(i) = 10*log10(snr_dsb);
end
plot(WW, snr_dsb_dB)

%% DSB part c
clear;clc;
T = 300;
K = 1.38e-23;
N0 = K*T;
Ac = 1;
fc = 400000;

load audio;
Fs = 8000;
t = 0:1/Fs:(numel(y)-1)*1/Fs;
y = y';
ymod = dsb_modulator(y, t, Fs, fc, Ac);
ych = channel(ymod, t, Fs, N0);
ydemod = dsb_demodulator(ych, t, Fs, fc);
player = audioplayer(ydemod, Fs);
play(player);

%% PM part a and c and d
clc; clear;
global Fs
Fs = 4e5;
T = 300;
K = 1.38e-23;
N0 = K*T;

recObj1 = audiorecorder;
disp("Start Recording");
recordblocking(recObj1, 5);
disp("Stop Recording");
fs = recObj1.SampleRate; 
msg = getaudiodata(recObj1);

[msg_mod, t_for_demod] = pm_modulator(fs, msg);
t = 0:1/fs:(numel(msg)-1)/fs;
msg_ch = channel(msg_mod, t, fs, N0);
msg_demod = pm_demodulator(msg_ch, t_for_demod);
m = downsample(msg_demod, Fs / fs);
player=audioplayer(m, fs);
play(player)

%calculating the SNR
% Ac = 1; W = 1;
% msg = cos(2*pi*W*t)+10*sin(16*pi*W*t);
% [msg_mod, t_for_demod] = pm_modulator(W, msg);
% t = 0:1/W:(numel(msg)-1)/W;
% msg_ch = channel(msg_mod, t, W, 0);
% msg_demod = pm_demodulator(msg_ch, t_for_demod);
% signal = msg_demod;
% s_pow = mean(signal.^2);
% 
% [msg_mod, t_for_demod] = pm_modulator(W, msg);
% t = 0:1/W:(numel(msg)-1)/W;
% msg_ch = channel(msg_mod, t, W, N0);
% msg_demod = pm_demodulator(msg_ch, t_for_demod);
% noisySignal = msg_demod;
% noise = noisySignal - signal;
% n_pow = mean(noise.^2);
% 
% snr_dsb = (s_pow / n_pow)
% snr_dsb_dB = 10*log10(snr_dsb)




% fs = 100:50000:200000;
% snr_pm_dB = 100:50000:200000;
% %msg = cos(2*pi*W*t);
% 
% for i = 1:length(fs)
%     [msg_mod, t_for_demod] = pm_modulator(fs(i), msg);
%     msg_ch = channel(msg_mod, t, fs(i), 0);
%     msg_demod = pm_demodulator(msg_ch, t_for_demod);
%     signal = msg_demod;
%     s_pow = mean(signal.^2); 
%
%     [msg_mod, t_for_demod] = pm_modulator(fs(i), msg);
%     msg_ch = channel(msg_mod, t, fs(i), N0);
%     msg_demod = pm_demodulator(msg_ch, t_for_demod);
%     noisySignal = msg_demod;
%     noise = noisySignal - signal;
%     n_pow = mean(noise.^2);
%
%     snr_pm = s_pow / n_pow;
%     snr_pm_dB(i) = 10*log10(snr_pm);
% end
% plot(fs,snr_pm_dB)