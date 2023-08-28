clear; clc;
deviceReader = audioDeviceReader(1e5);
deviceWriter = audioDeviceWriter('SampleRate',
                       deviceReader.SampleRate);
T = 300;
K = 1.38e-23;
N0 = K*T;
fs = 8000;
disp('Begin Signal Input...')

while 1
    y = deviceReader();        
    t = 0:1/fs:(numel(y)-1)*1/fs;
    myProcessedSignal = dsb_modulator(y', t, 8000, 400000, 1);
    myProcessedSignal_chn = channel(myProcessedSignal, t, fs, 0);
    m = dsb_demodulator(myProcessedSignal_chn, t, 8000, 400000);
    deviceWriter(m');     
    
    % pause(0.05);
end
disp('End Signal Input')

release(deviceReader)
release(deviceWriter)