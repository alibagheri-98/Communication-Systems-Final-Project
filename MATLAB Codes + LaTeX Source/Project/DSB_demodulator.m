function Y = DSB_demodulator(Ac,fc,dsbMOD,t,fpass)
    fsample = length(t)/t(length(t));
    D = dsbMOD.*cos(2*pi*fc.*t);
    Y = lowpass(D,fpass,fsample);
    
end
