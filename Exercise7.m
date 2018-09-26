%% Exercise 7

R = 9.73;
L = 0;
kt = 0.0278;
ke = 0.0278;
Jm = 24.2*10^(-7);
f = 0;
Jl = 5.0*10^(-4);
N = 45;
mb = 0;
Jlm=Jl/N^2
Jtot=Jlm+Jm
J=Jtot;

Vcc = 10;
Vdd = 0;
pot = 352; %deg

%% 7.1.1
% Find the potentiometer constant kpot in V/rad
Kpot = Vcc/(deg2rad(pot))

%% 7.1.2
[A,B,C,D] = linmod('Exercise712');
[num,den]= ss2tf(A,B,C,D);
sys = tf(num,den)

%% 7.1.3
deltaw=logspace(0,3,10000);
[m,p,w]=bode(sys,deltaw);

index = find(p <= -110,1)
mag = m(index)
Kp = 1/mag

w0 = getGainCrossover(Kp*sys,1)

%% 7.1.4

tau = 5/w0;
I = tf([tau 1],[tau 0]);
[m,p,w] = bode(I*sys,deltaw);
index = find(p == max(p),1);
mag = m(index);
Kp = 1/mag;
K=Kp

[Num Den] = tfdata(K*I);
Num = cell2mat(Num);
Den = cell2mat(Den);
Num = Num/Den(1)
Den = Den/Den(1)

%% 7.1.5

[m,p,w] = bode(K*I*sys,deltaw);
index = find(m == 1);
p0 = p(index)+180

%% 7.1.6

w0 = w(index)

%% 7.2.1
fs = 20*w0/(2*pi);
Ts = 1/fs

%% 7.2.2
sysd = c2d(sys,Ts)

%% 7.2.3
deltaw=logspace(0,3,10000);
[m,p,w]=bode(sysd,deltaw);

index = find(p <= -110,1)
mag = m(index)
Kp = 1/mag

w0 = getGainCrossover(Kp*sys,1)

%% 7.2.4
tau = 5/w0;
I = tf([tau 1],[tau 0]);
Id = c2d(I,Ts,'tustin')
[m,p,w] = bode(Id*sysd,deltaw);
index = find(p == max(p),1);
mag = m(index);
Kp = 1/mag;
K=Kp

[Num Den] = tfdata(K*Id);
Num = cell2mat(Num);
Den = cell2mat(Den);
Num = Num/Den(1)
Den = Den/Den(1)

%% 7.2.5

[m,p,w] = bode(K*Id*sysd,deltaw);
index = find(m <= 1,1);
p0 = p(index)+180

%% 7.2.6

w0 = w(index)

%% 7.3.1
deltaw=logspace(0,3,10000);
[m,p,w]=bode(sys,deltaw);

index = find(p <= -135,1)
mag = m(index)
Kp = 1/mag

w0 = getGainCrossover(Kp*sys,1)

taud = 1/w0
alpha = 0.2
D = tf([taud 1],[alpha*taud 1])


deltaw=logspace(0,3,10000);
[m,p,w]=bode(D*sys,deltaw);

index = find(p <= -105,1)
mag = m(index)
Kp = 1/mag


[Num Den] = tfdata(Kp*D);



Num = cell2mat(Num);
Den = cell2mat(Den);
Num = Num/Den(1)
Den = Den/Den(1)
tf(Num,Den)

%% 7.3.2
w0 = getGainCrossover(Kp*D*sys,1)

%% 7.4.1
fs = 30*w0/(2*pi);
Ts = 1/fs

%% 7.4.2
sysd = c2d(sys,Ts)

%% 7.4.3

% taud from continuous
taud = 0.033570096932448
zero = (1-Ts/(2*taud))/(1+Ts/(2*taud))


%% 7.4.4
pole1 = ((alpha+1)*zero+alpha-1)/((alpha-1)*zero+alpha+1)

num=[1 -zero]
den=[1 -pole1]

deltaw=logspace(0,3,10000);
[m,p,w]=bode(tf(num,den,Ts)*sysd,deltaw);

index = find(p <= -105,1);
mag = m(index);
Kp = 1/mag

c = Kp*tf(num,den,Ts)

%% 7.1.5

w0 = getGainCrossover(Kp*tf(num,den,Ts)*sysd,1)
