clear;
clc;
T = 300;
K = 1.38e-23;
N0 = K*T;
Ac = 1;
fc = 400000;

% signal
t=0:0.0005:20;
WW = linspace(0.1,1000,100);
snr_dsb_dB = linspace(5,5000,100);
for i = 1:100
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