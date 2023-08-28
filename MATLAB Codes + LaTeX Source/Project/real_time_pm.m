clear; close all; clc;
global Fs
T = 300;
K = 1.38e-23;
N0 = K*T;
Fs = 400000;

deviceReader = audioDeviceReader(8000);
deviceWriter = audioDeviceWriter('SampleRate',
                    deviceReader.SampleRate);
fs = 8000;
disp('Begin Signal Input...')
while 1
    y = deviceReader();
    [myProcessedSignal, t] = pm_modulator(fs,y);
    myProcessedSignal_chn = channel(myProcessedSignal, t, fs, N0);
    m = pm_demodulator(myProcessedSignal_chn, t);
    m = downsample(m, (400000) / fs);
    deviceWriter(m');
    %pause(0.05);
end
disp('End Signal Input')

release(deviceReader)
release(deviceWriter)