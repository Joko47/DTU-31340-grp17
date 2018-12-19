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

%% 9