clear all;  
% Audio Input  
 [x,Fs] = audioread('Nirma.wav');  
 sound(x,Fs)
 
pause(4);  
 delay = 0.5; % 0.5s delay  
 alpha = 0.65; % echo strength  
 D = delay*Fs;  

% Echoed Signal
y = zeros(size(x));  
 y(1:D) = x(1:D);  
   
 for i=D+1:length(x)  
   y(i) = x(i) + alpha*x(i-D);  
 end
 
% echoed audio signal
 sound(y,Fs); 
 audiowrite('Nirma Echoed.wav',y,Fs);
 
%Scalling Input and Echoed Output
p=x(:);
p=p(1:length(p)/2);
p=p';

z=y(:);
z=z(1:length(z)/2);
z=z';

%Echo cancellation by Adaptive Filter
b = fir1(31,0.5);     % FIR system to be identified
mu= 0.008;            % LMS step size.
ha= adaptfilt.lms(32,mu);
[res,e] = filter(ha,p,z);

%Regenerated Sound from Echoed Sound
sound(res,Fs);
audiowrite('Nirma Regenerated.wav',res,Fs)

%Plots
%Original Signal
subplot(3,1,1); plot(x);
title('Original Signal');
xlabel('Time Index'); ylabel('Signal Value');

%Echoed Signal
subplot(3,1,2); plot(y);
title('Echoed Signal');
xlabel('Time Index'); ylabel('Signal Value');

%Regenerated Signal
subplot(3,1,3); plot(res);
title('Regenerated Signal');
 xlabel('Time Index'); ylabel('Signal Value');