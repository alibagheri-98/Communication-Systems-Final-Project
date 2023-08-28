function msg_demod = pm_demodulator(msg_ch, t_for_demod)
global Fs
msg_ch_prime = bandpass(msg_ch, [9e4 11e4], Fs);
derivative = diff(msg_ch_prime) / (t_for_demod(2) - t_for_demod(1));
envelope = sqrt(derivative.^2 + imag(hilbert(derivative)).^2);
DCR = envelope - movmean(envelope,2500);
msg_demod_with_DC = (t_for_demod(2) - t_for_demod(1))*cumsum(DCR);
DCR_msg = msg_demod_with_DC - movmean(msg_demod_with_DC,2500);
msg_demod = DCR_msg;
end