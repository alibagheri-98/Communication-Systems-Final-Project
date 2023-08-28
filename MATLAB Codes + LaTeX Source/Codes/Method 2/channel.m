function [chn, t] = channel(mod, t, W, N0) 
B = 2*W;
n_pow = 2*N0/2*B;
s_pow = mean(mod.^2);
snr_ch = 10*log10(s_pow/n_pow);
chn = awgn(mod, snr_ch, 'measured');
end