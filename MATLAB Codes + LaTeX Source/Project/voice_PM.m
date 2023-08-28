Fs = 4e5;
recObj1 = audiorecorder;
disp("Start Recording");
recordblocking(recObj1, 5);
disp("Stop Recording");
fs = recObj1.SampleRate; 
msg = getaudiodata(recObj1);
% pm
T = 300;
K = 1.38e-23;
N0 = K*T;
[msg_mod, t_for_demod] = pm_modulator(fs, msg);
t = 0:1/fs:(numel(msg)-1)/fs;
msg_ch = channel(msg_mod, t, fs, N0);
msg_demod = pm_demodulator(msg_ch, t_for_demod);
m = downsample(msg_demod, Fs / fs);
player=audioplayer(m, fs);
play(player)
