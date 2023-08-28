# Communication-Systems-Final-Project

In this repository, our goal is to simulate a real-time communication system using MATLAB.
![Screenshot (4600)](https://github.com/alibagheri-98/Communication-Systems-Final-Project/assets/112773855/afe8fac2-8ad2-4db8-a912-dc4071e11525)
To achieve this, we will proceed through the following steps:

1) Assume that the modulator and demodulator are PM. We write a MATLAB code to simulate the
PM communication system. Then we create separate MATLAB functions for the modulator, demodulator,
and channel. Finally, connect them in a main mfile. Name the functions pm_modulator, channel, and
pm_demodulator

2) Now we repeat the previous part for a DSB communication system. Note that the channel function does
not change. We only need to code two new functions for the DSB modulator and demodulator.
These new functions are named dsb_modulator and dsb_demodulator.

3) Next, we feed our simulation codes with a recorded audio file and play the demodulated signal and hear
it for different noise levels in the channel.
Note that you can record your voice from your laptop microphone and feed it to the modulator. You
can also play the demodulated signal and hear it from your laptop speaker. MATLAB has useful
internal commands for working with microphones and speakers!

4) Then, we compare the SNR performance of the simulated PM and DSB communication systems. To do
this, we can plot the output SNR of both systems in terms of the channel noise level, message
bandwidth, and so on.

5) Finally we make our simulation setup realtime. In this way, you talk to the microphone and hear the demodulated signal from the speaker simultaneously without any delay and lag

