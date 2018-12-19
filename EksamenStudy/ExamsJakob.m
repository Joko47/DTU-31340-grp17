%% Exam 2017

%% 1
sys = tf(0.5,[0.04 1 0]);
T = 0.01;
c2d(sys,T)

%% 2
T= 0.01;
sysd = tf([3.3*10^(-3) 2.6*10^(-3)],[1 -1.40 0.40],T);

deltaw=logspace(0,3,10000);
[m,p,w]=bode(sysd,deltaw);

index = find(p <= -120,1);
mag = m(index);
Kp = 1/mag

%% 3
T= 0.01;
sysd = tf([3.3*10^(-3) 2.6*10^(-3)],[1 -1.40 0.40],T);
ctrd = tf([0.1541 -0.1441],[1 -1],T);

Kp=[130.1,100.43,83.9,159.4,55.2];
phase = [];

for n = 1:length(Kp)
    [Gm,Pm,Wcg,Wcp] = margin(sysd*Kp(n)*ctrd);
    phase = [phase Pm];
end;

Kp(find(phase == max(phase),1))

%% 4
% freq = 100 Hz (1/0.01) nyquist = 50 Hz singal  = 44 Hz no aliasing

%% DC limit
%% 5
% 0.5 hAD
%% 6
A=tf([1],[1 -0.99],0.1)
B=tf([0.15],[1.3 -1],0.1)
X=A*B
evalfr(X,1)/2
%% 7
evalfr(B,1)/2
%% 8
1/2
%% 9

%% Large signal
%% 10
evalfr(tf([0.01],[1 -0.99],0.1),1)

%% 11
evalfr(tf([1 -0.98],[1 -0.99],0.1),1)
%% 12
evalfr(tf([1 -0.98],[1 -0.99],0.1)*tf([1],[1.3 -1],0.1),1)
%% 13
% always 1

%% 14

%% 15
hAD = 11;
bit = 10;
l = 1-0;
l*(hAD/2^bit)*1000 %1000 for m to mm

%% 18

-((10-(-10))/l)

%% 19

1/1

%% 20


%% 21
s1 = 0.1;
d1 = 0.01;

s2 = 0.05;
d2 = 0.02;

s3 = 0.1;
d3 = 0.01;

min = d1+d2+d3
max = s1+d1+s2+d2+s3+d3


%% Exam 2016

%% 1
sys = tf([0.5],[0.001 0.11 1 0])
T = 0.02;

c2d(sys,T)

%% 2
10^(-18/20)
10^(19/20)

%% 3
% 50 Hz (1/0.02) signal = 48 Hz, mirrored in 25 Hz = 2 Hz

%% DC LIMIT
%% 4
% Always 0.5 when expressed in h_AD
%% 5
a=0.06
b=0.02
c=0.8
d=0.2

% Find B using pdf page X and Maple
B=tf([1],[1 -0.98],0.1);
C=tf([1 -0.8],[1 -0.2],0.1);
X=B*C
evalfr(X,1)/2

%% 6
B=tf([1],[1 -0.98]);
C=tf([1 -0.8],[1 -0.2]);
X=B*C
evalfr(X,1)/2

%% 7
C=tf([1],[1 -0.2]);
evalfr(C,1)/2
%% 8

%% LARGE SIGNAL
%% 9
%% 10
%% 11
%% 12
%% 13

%% 14
hAD= 7;
bit = 12;
l = 0.8-0;
l*(hAD/2^bit)*1000 %1000 for m to mm

%% 15
-(10-(-10))/(0.8-0)
%% 16-19
% b0 = 1 as 1=1 in first step
% Simulink
tf([1 -0.4],[1 -0.9 0.08]) 

%% 20
% see pdf

%% 21
% see pdf



%% 22
1/2.2

%% Exam 2015

%% 1
T = 0.01;
sys = tf([200],[1 40 0 0]);

sysd = c2d(sys,T)

%% 2
z = tf('z',T);
sys_dr = ((4.3*10^-3*z+3.6*10^-3)/(z^2-1.6*z+0.6));
Dz = 10;
de = minreal(1/(1+Dz*sys_dr)); 
ramp = 0.1*z/(z-1)^2;
rz2 =minreal((ramp*de*((z-1)/z)),10^-6);
[m,p]= bode(rz2,0);
Gain = m
%% 3
[Gm,Pm,Wcg,Wcp] = margin(tf([4.3*10^-3 3.6*10^-3],[1 -1.6 0.6],T)*10)
20*log10(Gm)

%% 14
hAD= 9;
bit = 12;
l = 360-0;
l*(hAD/2^bit)
%% 22
k1 = 4.8;
k2 = 0.2;
k3 = 2;

tf([k1 k1-k2*k3],[1 -k3^2*k2],0.1)

%% 23
1/3.2

%% 24
1/(3.2+3.1-0.9)




