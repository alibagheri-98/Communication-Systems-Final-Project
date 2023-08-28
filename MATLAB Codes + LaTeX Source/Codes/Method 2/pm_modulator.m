function [msg_mod, t_for_demod] = pm_modulator(fs, msg)
global Fs
msg_mod_prime = upsample(msg, Fs / fs);
N = numel(msg_mod_prime);
t_for_demod = 0:(1/Fs):(N-1)/Fs;
msg_zegond = lowpass(msg_mod_prime, 4000, Fs, 'ImpulseResponse', 'iir', 'Steepness', 0.95); 
msg_mod = cos(2*pi*(1e5)*t_for_demod + (msg_zegond')/max(abs(msg_zegond)));
end