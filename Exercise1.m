%% Exercise 1
% Stability

Step_Time = 1; %Step Time
Fin_Val = 1;   % Final step value
Den = 1;       % Denumerator

%Gain 0.5
Num = 0.5;     % Numerator
sim('Simulink/Exercise111');
plot(simout.time, simout.signals.values)
title('Gain 0.5')
%%
%Gain 1
Num = 1;
sim('Simulink/Exercise111');
plot(simout.time, simout.signals.values)
title('Gain 1.0')
%%
%Gain 1.5
Num = 1.5;
sim('Simulink/Exercise111');
plot(simout.time, simout.signals.values)
title('Gain 1.5')
%%
%Gain 2
Num = 2;
sim('Simulink/Exercise111');
plot(simout.time, simout.signals.values)
title('Gain 2.0')
Max2 = max(simout.signals.values);

%%
%Gain 2.3
Num = 2.3;
sim('Simulink/Exercise111');
plot(simout.time, simout.signals.values)
title('Gain 2.3')
%% Exercise 1.1.1 and 1.1.2
% What is the maximum output for gain 2.0?
% What is the gain limit for a stable continuous system?
fprintf('max output = %.3f ',Max2);
display('The maximum gain is infinite');

%% Exercise 1.1.3 and 1.1.4
% What is the maximum output for gain 2.0?
% What is the gain limit for a stable sampled system?
Num = 2;
sim('Simulink/Exercise112');
plot(simout.time, simout.signals.values)
Max2 = max(simout.signals.values);
fprintf('max output = %.3f ',Max2);
display('The maximum gain is 2(marginally stable)');

%% Exercise 1.2
%% Exercise 1.2.1/2
% What is the maximum output for the continous and discrete system, sampletime 0.35?
Ts = 0.35;
sim('Simulink/Exercise121');
plot(simout.time, simout.signals.values);
Max = max(simout.signals.values);
fprintf('Ts = %.2f',Ts);
fprintf('max cont: %.3f, max disc: %.3f',Max(1), Max(2));
%% Exercise 1.2.3/4
% What is the maximum output for the continous and discrete system, sampletime 0.4?
Ts = 0.4;
sim('Simulink/Exercise121');
plot(simout.time, simout.signals.values);
Max = max(simout.signals.values);
fprintf('Ts = %.2f',Ts);
fprintf('max cont: %.3f, max disc: %.3f',Max(1), Max(2));
%% Exercise 1.2.5/6
% What is the maximum output for the continous and discrete system, sampletime 0.45?
Ts = 0.45;
sim('Simulink/Exercise121');
plot(simout.time, simout.signals.values);
Max = max(simout.signals.values);
fprintf('Ts = %.2f',Ts);
fprintf('max cont: %.3f, max disc: %.3f',Max(1), Max(2));