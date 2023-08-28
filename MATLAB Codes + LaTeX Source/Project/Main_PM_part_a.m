clc;
  
fc = 1E6; 
Ac = 10; 
Kp = 10;

m = @(t) cos(2*pi*1E4*t) + cos(2*pi*0.7E4*t) + cos(2*pi*0.4E4*t);
fMax = 1E4;
Tmax = 10 / fMax;
PM_System(Ac,fc,Kp,Tmax,m,0.1);


function Y = PM_System(Ac,fc,Kp,Tmax,m,snr)

    t = linspace(0,Tmax,Tmax*10*fc);
    Modulated = PM_modulator(Ac,fc,Kp,m);
    PMOD = [];
    M = [];
    for i=1:length(t)
        PMOD(i) = Modulated(t(i));
        M(i) = m(t(i));
    end
    subplot(4,1,1)
    plot(M,'linewidth',2,'color','black')
    title("First Signal")
    subplot(4,1,2)
    plot(PMOD,'linewidth',2,'color','red')
    title("Modulated Signal")
    PMOD1 = channel(PMOD,snr);
    subplot(4,1,3)
    plot(PMOD1,'linewidth',2,'color','green')
    title("Modulated Signal Passed Through Channel")
    PDEMOD = PM_demodulator(Ac,fc,Kp,PMOD1,t);
    subplot(4,1,4) 
    plot(PDEMOD,'linewidth',2,'color','blue')
    title("Demodulated Recieved Signal")
    Y = PDEMOD;
end
