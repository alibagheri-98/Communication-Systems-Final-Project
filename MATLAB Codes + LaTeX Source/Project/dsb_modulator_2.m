function [mod, t] = dsb_modulator(msg, t, W, fc, Ac)
mixed = Ac*msg.*cos(2*pi*fc*t);
B = 2*W;
bpf = abs(t(2)-t(1))*2*B*sinc(B*t).*cos(2*pi*fc*t);
mod = conv(mixed, bpf);
mod = mod(1:numel(t));
end