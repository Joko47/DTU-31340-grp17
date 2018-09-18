%% Exercise 4

%% 4.1.1
% Find H_zoh(z) for G(s) = 1/s
T = 0.5;
syms z
H = T/(z-1)

c2d(tf([1],[1 0]),T)
%% 4.1.2
% Find H_zoh(z) for G(s) = 1/(s*(s+1))

z = tf('z',T)
H = ((exp(-T)+T-1)*z+(1-(1+T)*exp(-T)))/((z-1)*(z-exp(-T)))

c2d(tf([1],[1 1 0]),T)


%% 4.2.1
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
%%
J=Jtot;

simul = sim('Exercise42')


t = simout.time
input = simout.data(:,1)
output = simout.data(:,1)


%%
T=0.005
a=29.78
num = (1-exp(-a*T))*35.96
den = [1 -exp(-a*T)]


%%
K=0.1724;

[A,B,C,D] = linmod('Exercise42');
[num,den]= ss2tf(A,B,C,D);
step(tf(num,den))
%fives out 0.861


%%

K=0.1724*1.5;

[A,B,C,D] = linmod('Exercise42');
[num,den]= ss2tf(A,B,C,D);
step(tf(num,den))


%% problem 4.3.2

%%the systems with the P controller is 

%Gs=4.997K/(z-0.8616)

%H = Gs / (1 + Gs)

%to find that the pole is equal to zero we should do

%(1 + Gs) = 0

%1=4.997K/(z-0.8616) 

%making z = 0 and solving to K;
%K= 0.8616/4.997=0.1724


