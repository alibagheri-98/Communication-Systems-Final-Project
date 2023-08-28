clc;
  
fc = 1E6; 
Ac = 10; 
Kp = 10;

m = @(t) cos(2*pi*1E4*t) + cos(2*pi*0.7E4*t) + cos(2*pi*0.4E4*t);
fMax = 1E4;
Tmax = 10 / fMax;
DSB_System(Ac,fc,Tmax,m,0.1);

function Y = DSB_System(Ac,fc,Tmax,m,snr)
    dsbMOD_T = DSB_modulator(Ac,fc,m);
    t = linspace(0,Tmax,Tmax*10*fc);
    dsbMOD = [];
    M = [];
    for i=1:length(t)
        dsbMOD(i) = dsbMOD_T(t(i));
        M(i) = m(t(i));
    end
    subplot(4,1,1)
    plot(M,'linewidth',2,'color','black')
    title("First Signal")
    subplot(4,1,2)
    plot(dsbMOD,'linewidth',2,'color','red')
    title("Modulated Signal")
    dsbMOD1 = channel(dsbMOD,snr);
    subplot(4,1,3)
    plot(dsbMOD1,'linewidth',2,'color','green')
    title("Modulated Signal Passed Through Channel")
    dsbDEMOD = DSB_demodulator(Ac,fc,dsbMOD1,t,2E4);
    subplot(4,1,4)
    plot(dsbDEMOD,'linewidth',2,'color','blue')
    title("Demodulated Recieved Signal")
    Y = dsbDEMOD;
end