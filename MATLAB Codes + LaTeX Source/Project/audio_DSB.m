%part c
load audio;
Fs = 8000;
t = 0:1/Fs:(numel(y)-1)*1/Fs;
y = y';
ymod = dsb_modulator(y, t, Fs, fc, Ac);
ych = channel(ymod, t, Fs, N0);
ydemod = dsb_demodulator(ych, t, Fs, fc);
player = audioplayer(ydemod, Fs);
play(player);