function Y = PM_modulator(Ac,fc,Kp,m)
    Y = @(t) Ac * cos(2*pi*fc*t+Kp*m(t));
end