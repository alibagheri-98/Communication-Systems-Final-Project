T = 300;
K = 1.38e-23;
N0 = K*T;
t = 0:0.05:20;
fs = 100:50000:200000;
snr_pm_dB = 100:50000:200000;
msg = cos(2*pi*W*t);

for i = 1:length(fs)
    [msg_mod, t_for_demod] = pm_modulator(fs(i), msg);
    msg_ch = channel(msg_mod, t, fs(i), 0);
    msg_demod = pm_demodulator(msg_ch, t_for_demod);
    signal = msg_demod;
    s_pow = mean(signal.^2); 
    [msg_mod, t_for_demod] = pm_modulator(fs(i), msg);
    msg_ch = channel(msg_mod, t, fs(i), N0);
    msg_demod = pm_demodulator(msg_ch, t_for_demod);
    noisySignal = msg_demod;
    noise = noisySignal - signal;
    n_pow = mean(noise.^2);
    snr_pm = abs(s_pow / n_pow);
    snr_pm_dB(i) = 10*log10(snr_pm);
end
plot(fs,snr_pm_dB)