%% Exercise 2

%% Exercise 2.1.1/2/3/4
% * What is the maximal absolute difference between the sampled and
% continous signal (f=0.2)?
% * What is the maximal absolute difference between the sampled and continous signal (f=1.0)?
% * What is the maximal absolute difference between the sampled and continous signal (f=4.0)?
% * What is the maximal absolute difference between the sampled and continous signal (f=4.5)?

for Freq = [0.2,1,4,5]
    Freq = Freq*2*pi;
    sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
diff = simout.signals.values(:,1)-simout.signals.values(:,2);
Max = max(abs(diff));
peak = max(simout.signals.values(:,1));
bot = min(simout.signals.values(:,1));
amp = (abs(bot)+abs(peak))/2;
fprintf('Freq = %.2f\n',Freq/(2*pi))
fprintf('difference: %.3f, amplitude is: %.3f\n',Max, amp)
end
%% Exercise 2.1.5
% * What is the amplitude of the sampled signal (f=5)?
Freq = 5*2*pi;
sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
amp = max(simout.signals.values(:,1));
fprintf('At frequency = %.1f, amplitude is %.1f',Freq/(2*pi),amp);

%% Exercise 2.1.6/7
% * What is the frequency of the sampled signal (f=9)?
% * What is the frequency of the sampled signal (f=9.8)?
Freq = 9*2*pi;
sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
fprintf('At frequency = %.1f, seen as 1 Hz\',Freq/(2*pi));

Freq = 9.8*2*pi;
sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
fprintf('At frequency = %.1f, seen as 1 Hz',Freq/(2*pi));

%% Exercise 2.1.8/9
% * What is the amplitude of the sampled signal (f=10)?
% * What is the amplitude of the sampled signal (f=50)?
Freq = 10*2*pi;
sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
amp = max(simout.signals.values(:,1))
fprintf('At frequency = %.1f, amplitude is %.1f\n',Freq/(2*pi),amp);

Freq = 50*2*pi;
sim('Simulink/Exercise21');
plot(simout.time, simout.signals.values);
amp = max(simout.signals.values(:,1))
fprintf('At frequency = %.1f, amplitude is %.1f',Freq/(2*pi),amp);

%% Exercise 2.2.1
% What is the peak to peak noise amplitude on the system output (f=0.8)?
k=1

Freq = 0.8*2*pi;
sim('Simulink/Exercise22');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.2.2
% What is the peak to peak noise amplitude on the system output (f=2.2)?
Freq = 2.2*2*pi;
sim('Simulink/Exercise22');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.2.3
% What is the peak to peak noise amplitude on the system output (f=10.2)?
Freq = 10.2*2*pi;
sim('Simulink/Exercise22');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);


%% Exercise 2.3
%% Exercise 2.3.1
% What is the peak to peak noise amplitude on the system output (f=0.8)

k=1
Freq = 0.8*2*pi;
sim('Simulink/Exercise23');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.3.2
% What is the peak to peak noise amplitude on the system output (f=2.2)
Freq = 2.2*2*pi;
sim('Simulink/Exercise23');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.3.3
% What is the peak to peak noise amplitude on the system output (f=10.2)?

Freq = 10.2*2*pi;
sim('Simulink/Exercise23');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.3.4/5
% * What is the maximum output error (f=5)?
% * What is the frequency of the output error signal (f=5)?
Freq = 5*2*pi;
sim('Simulink/Exercise23');
plot(simout.time, simout.signals.values);
maxE = max(simout.signals.values(:,1)-1);
fprintf('The steadystate error is: %.3f\n',maxE);
fprintf('The frequency is 0, as there are no sinewave');    


%% Exercise 2.4
%% Exercise 2.4.1
% What is the peak to peak noise amplitude on the system output (f=0.8)?
Tau = 0.159;

Freq = 0.8*2*pi;
sim('Simulink/Exercise24');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.4.2
% What is the peak to peak noise amplitude on the system output (f=2.2)?
Freq = 2.2*2*pi;
sim('Simulink/Exercise24');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);

%% Exercise 2.4.3
% What is the peak to peak noise amplitude on the system output (f=10.2)?

Freq = 10.2*2*pi;
sim('Simulink/Exercise24');
plot(simout.time, simout.signals.values);
peak = max(simout.signals.values(2700:end,1));
bot = min(simout.signals.values(2700:end,1));
amp = peak-bot;
fprintf('The frequency is: %.3f',amp);
%% Exercice 2.4.4/5
% * What is the maximum output error (f=5)?
% * What is the frequency of the output error signal (f=5)?
Freq = 5*2*pi;
sim('Simulink/Exercise24');
plot(simout.time, simout.signals.values);
maxE = max(simout.signals.values(5005,1))-1;
fprintf('The steadystate error is: %.3f\n',maxE);
fprintf('The frequency is 0, as there are no sinewave');  

%% Exercise 2.5
% * What is the value of tau? (calculate)
% * What is the value of k?   (simulate step respose without noise)
Tau = 1/(2*pi*0.22);
k=0.6;
Freq = 2.2*2*pi;
set_param('Exercise24','StopTime','50');
sim('Simulink/Exercise24');
plot(simout.time, simout.signals.values);
dampening = (max(simout.signals.values(2700:end,2))-1)/(max(simout.signals.values(2700:end,1))-1);
overshoot = (max(simout.signals.values(:,1))-1)*100;
fprintf('Tau is: %.3f, Dampening: %.1f\n',Tau,dampening);
fprintf('k is: %.3f, overshoot: %.2f%%\n' ,k, overshoot);
set_param('Simulink/Exercise24','StopTime','10');

