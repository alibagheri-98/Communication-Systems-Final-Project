clc;
  
fc = 1E6; 
Ac = 10; 
Kp = 10;

m = @(t) cos(2*pi*1E4*t) + cos(2*pi*0.7E4*t) + cos(2*pi*0.4E4*t);
fMax = 1E4;
Tmax = 10 / fMax;
DSB_System(Ac,fc,Tmax,m,0.1);
figure 
PM_System(Ac,fc,Kp,Tmax,m,0.1);

%to cacluate snr, uncomment the next 2 lines(because it takes so much time i commented it)

%figure
%SNR_TEST()

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


function SNR_TEST()
    m1 = @(t) 0;
    m2 = @(t) cos(2*pi*1E4*t) + cos(2*pi*0.7E4*t) + cos(2*pi*0.4E4*t);
    fc = 1E6; 
    Ac = 10; 
    Kp = 4000;
    fMax = 1E4;
    Tmax = 10 / fMax;
    snrChannel = linspace(0,10,100);
    snr_output_dsb = [];
    snr_output_pm = [];
    
    for j = 1:length(snrChannel)
        
        
        t = linspace(0,Tmax,Tmax*500*fc);
        Modulated = PM_modulator(Ac,fc,Kp,m1);
        PMOD = [];
        for i=1:length(t)
            PMOD(i) = Modulated(t(i));
        end
        PMOD = channel(PMOD,snrChannel(j));
        PDEMOD = PM_demodulator(Ac,fc,Kp,PMOD,t);
        Y1 = PDEMOD;     
        t = linspace(0,Tmax,Tmax*500*fc);
        Modulated = PM_modulator(Ac,fc,Kp,m2);
        PMOD = [];
        for i=1:length(t)
            PMOD(i) = Modulated(t(i));
        end
        PDEMOD = PM_demodulator(Ac,fc,Kp,PMOD,t);
        Y2 = PDEMOD;
        snr_output_pm(j) = cumsum((Y2 - Y1).*(Y2 - Y1)) / cumsum((Y1).*(Y1));
        
        
        
        
        
        t = linspace(0,Tmax,Tmax*500*fc);
        Modulated = DSB_modulator(Ac,fc,m1);
        PMOD = [];
        for i=1:length(t)
            PMOD(i) = Modulated(t(i));
        end
        PMOD = channel(PMOD,snrChannel(j));
        PDEMOD = DSB_demodulator(Ac,fc,PMOD,t,fMax);
        Y1 = PDEMOD;
        t = linspace(0,Tmax,Tmax*500*fc);
        Modulated = DSB_modulator(Ac,fc,m2);
        PMOD = [];
        for i=1:length(t)
            PMOD(i) = Modulated(t(i));
        end
        PDEMOD = DSB_demodulator(Ac,fc,PMOD,t,fMax);
        Y2 = PDEMOD;
        snr_output_dsb(j) = cumsum((Y2 - Y1).*(Y2 - Y1)) / cumsum((Y1).*(Y1));

    end
    
    plot(snrChannel,snr_output_pm,'linewidth',2,'color','black')
    hold on
    plot(snrChannel,snr_output_dsb,'linewidth',2,'color','red')
    xlabel("Channel SNR")
    ylabel("Output SNR")
    legend("Output SNR of PM System","Output SNR of DSB System")
    title("Output SNR per Channel SNR")
end