%% 1
Ts=0.01
sys = tf(200,[1 40 0 0])
c2d(sys,Ts)

%% 2

Ts=0.01
G0z=tf([4.3e-3 3.6e-3],[1 -1.6 0.6],Ts)
Dz=tf(10,1,Ts);


r=tf([1 -1],1,Ts)
sys= G0z*r
minreal(sys)
%notesbog

%% 3
bode(G0z*Dz)

%% 4
0.5 % always

%% 5
z = sym('z')

eq=(1 -0.9*z)/(1-0.95*z)*((0.2*z/(1-z)+1)/(1+0.4* z/(1-z)))
eq = simplify(eq)
bottom =  sym2poly(subs(eq, z, 1))

%%
eq=1/(1-0.95*z)*((0.2*z/(1-z)+1)/(1+0.4* z/(1-z)))
eq = simplify(eq)
top =  sym2poly(subs(eq, z, 1))

top/bottom/2

%% 6
eq=((0.2*z/(1-z))/(1+0.4* z/(1-z)))
eq = simplify(eq)
top =  sym2poly(subs(eq, z, 1))

top/bottom/2

%% 7
%notesbog

%% 8
%when delta nda1 = delta nad1 - IF NOT IDK
nda=10
nad=12;
2^(nad-nda) %maybe its this

%% 9-13
%notesbog

%% 14
hAD= 9;
bit = 12;
l = 360-0;
l*(hAD/2^bit)

%% 15
-((10-(-10))/(360-0)) %minus sign comes from the summation point

%% 16 mean power model closed loop
Gz0=tf(1,[1 -0.9],Ts)
%notesbog
Dz = tf([0.5 -0.45],[1 -0.98],Ts)


sys =tf([0.5 -0.47],[1 -0.98],Ts)

covar(Dz*Gz0/(1+Dz*Gz0),1/12)
%% 17 and 19
covar(Gz0/(1+Dz*Gz0),1/12)

%% 18
sys = tf([2 -2],[1 -0.98],Ts)
covar(sys*Gz0/(1+Dz*Gz0),1/12)

%% 20
hterm=1/3
mean1= -0.5*-1*Gz0/(1+Dz*Gz0)
mean2= -0.5*-sys*Gz0/(1+Dz*Gz0)
mean3= -0.5*-1*Gz0/(1+Dz*Gz0)
means = mean1+mean2+mean3
impulse(means)

%%
sys = tf([2 -2],[1 -0.98],Ts)
hhh = step(sys)*0.4
plot(hhh)