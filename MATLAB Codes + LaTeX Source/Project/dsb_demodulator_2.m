function [demod, t] = dsb_demodulator(chn, t, W, fc)
%chn = bandpass(chn, [0.9*fc 1.1*fc], Fs);
mixed = chn.*cos(2*pi*fc*t);
BL = 1*W;
lpf = abs(t(2)-t(1))*BL*sinc(BL*t);
demod = conv(mixed, lpf);
demod = demod(1:numel(t));
end