clear;
clc;
T = 300;
K = 1.38e-23;
N0 = K*T;
Ac = 1;
fc = 400000;

t=0:0.0005:20;
W = 5000;
msg = cos(2*pi*W*t);

mod = dsb_modulator(msg, t, W, fc, Ac);
chn = channel(mod, t, W, N0);
demod = dsb_demodulator(chn, t, W, fc);