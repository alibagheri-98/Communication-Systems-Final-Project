function Y = DSB_modulator(Ac,fc,m)
    Y = @(t) Ac * m(t) * cos(2*pi*fc*t);
end
