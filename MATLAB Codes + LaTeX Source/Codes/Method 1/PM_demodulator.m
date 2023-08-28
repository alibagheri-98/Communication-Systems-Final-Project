function Y = PM_demodulator(Ac,fc,Kp,PMOD,t)
    du = diff(PMOD);
    [Envel,chert] = envelope( du );
    phi_p = Envel./Ac - 2*pi*fc;
    phi_p = phi_p - mean(phi_p);
    Y = cumsum(phi_p);
end
