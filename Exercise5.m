%% Exercise 5

%% 5.1.1
% What is the magnitude in dB when the phase is -180 degrees?

Ts= 0.005;
sys=tf(4.977,[1 -0.8616],Ts);
deltaw=logspace(1,3,10000);
[m,p,w]=bode(sys,deltaw);

%% 5.1.2
%
index = find(p <= -120,1)
mag = m(index)
magdb=mag2db(mag)
Pd=db2mag(-magdb)


%% 5.1.3
sys=tf(Pd*4.977,[1 -0.8616],Ts);
deltaw=logspace(1,3,10000);
[m,p,w]=bode(sys,deltaw);
magdb=mag2db(m(:))
index = find(magdb <= 0,1)
freq = w(index)

getGainCrossover(sys,1)

%% 5.1.4
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

simout = sim('Exercise54')

t = simout.time;
input = simout.data(:,1);
output = simout.data(:,1);


%% 5.2.1
Ts= 0.005;
sys=tf(4.977,[1 -0.8616],Ts);
deltaw=logspace(1,3,10000);
[m,p,w]=bode(sys,deltaw);

maxP = db2mag(-8.54)

%% 5.2.2

0.3740

%% 5.3.1
Hs = d2c(sys)
[m,p,w] = bode(Hs,250);
Pc=1/m;
getGainCrossover(Pc*Hs,1)


simout = sim('Exercise531');
Ess=1-0.894

bode(Pd*sys);
hold on;
bode(Pc*Hs);
hold off;
