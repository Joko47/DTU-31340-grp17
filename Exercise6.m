%% Exercise 6
R=9.73;
L=0;
kt=0.0278;
ke=kt;
Jm=24.2*10^-7;
Jl=5.0*10^-4;
N=45
Mb=0;
f=0;
Jlm=Jl/N^2
Jtot=Jlm+Jm
J=Jtot;
P= 0.2204
Ts= 0.005;
%% 6.1.1
sim('Exercise611')

indext = find(simout.time == 0.5);
TorqueMin = min(simout.signals.values(indext:end))

%% 6.1.2
Torquess = simout.signals.values(end)

%% 6.2.1

tau = 1/(250/5)

%% 6.2.2
Is = tf([tau 1],[tau 0])
Iz = c2d(Is,Ts,'tustin')

%% 6.2.3

sys=tf(4.977,[1 -0.8616],Ts);
[m,p,w] = bode(Iz*sys);
Pz = db2mag(-16.7)

%% 6.2.4
w0 = getGainCrossover(Pz*Iz*sys,1)

%% 6.2.5
[Num,Den] = tfdata(Pz*Iz)
Numz = cell2mat(Num)
Denz = cell2mat(Den)

sim('Exercise625')
indext = find(simout.time == 0.5);
TorqueMin = min(simout.signals.values(indext:end))

%% 6.2.6
Torquess = simout.signals.values(end)

%% 6.3.1
Hs = d2c(sys);
[m,p,w] = bode(Is*Hs,w0)
Ps = 1/m


[Num,Den] = tfdata(Ps*Is)
Nums = cell2mat(Num)
Dens = cell2mat(Den)

Nums = Nums/0.02
Dens = Dens/0.02

%% 6.3.2
sim('Exercise632')
overshoot = (max(simout.signals.values(:))-simout.signals.values(end))/simout.signals.values(end)*100

%% 6.3.3
indext = find(simout.time == 0.5);
TorqueMin = min(simout.signals.values(indext:end))

%%
sim('Exercise625')
stairs(simout.time,simout.signals.values)
hold on;
sim('Exercise632')
plot(simout.time,simout.signals.values)
hold off;
legend('Discrete','Continuous')