%eksamen 2013

%% 1.1
sys = tf([100],[1 30 0])


Ts=0.01;
c2d(sys,Ts) %sol

%% 1.2


Ts=0.1
G0z=tf([0.1],[1 -1],Ts)
Dz=tf(4,1,Ts)


o = sym('o')
expand((o-1)^2)

rz=tf([0.1 0],[1 -2 1],Ts)


sys = G0z*Dz/(1+G0z*Dz)


sys =minreal(sys)
close all 
figure
ramp = impulse(rz)*Ts;
hold on
response = impulse(rz*sys)*Ts;

ramp(end)-response(end)%sol - or very very close

%% 1.3
%lazy mode
Kp=33;
Ki=69;
Kd=17;
Pcont = tf(Kp,1)
c2d(Pcont,Ts)

Icont = tf(Ki,[1 0])
c2d(Icont,Ts)


PIcont = tf([Kp Ki],[1 0])

impulse(c2d(PIcont,Ts))
%%
PDcont = tf([Kd 1],[1 1])
pdd = c2d(PDcont,Ts)
impulse(pdd)

%%

pidd = tf([1 -1.9288 0.9299],[1 -1.8113 0.8113],Ts)
impulse(pidd)

%% Problem 2.1
% top=(0.2*o+1)*(1-0.7*o)
% bottom=(1-o+0.1*o)*(1-0.4*o)
% num = double(coeffs(top))
% den = double(coeffs(bottom))
% sys = tf(num,den,1)
% minreal(sys)
% %
% subs(top, o, 1)
% subs(bottom, o, 1)
% 
% subs(top/bottom, o, 1)
%% gz
eq=((0.2*(o/(1-o))+1)/(1+0.1*(o/(1-o))+1))*((1-0.7*o)/(1-0.4*o))
eq = simplify(eq)
bottom =  sym2poly(subs(eq, o, 1))
%% b and c
eq=(((o/(1-o)))/(1+0.1*(o/(1-o))+1))*((1-0.7*o)/(1-0.4*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2
%% d
eq=(1/(1-0.4*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% Problem 2.2 
o = sym ('o')

% trying to cheating and getting transfer function from simulink
[A,B,C,D] = dlinmod('largeanal',1);
[num,den]= ss2tf(A,B,C,D);
sys = tf(num,den,1)

%% 2.2 c

eq=((0.2*(o/(1-o))+1)/(1+0.1*(o/(1-o))+1))
eq = simplify(eq)
subs(eq, o, 1)

%% 2.2 d
o = sym ('o')
eq=((0.2*(o/(1-o))+1)/(1+0.1*(o/(1-o))+1))*((1-0.7*o)/(1-0.4*o))
eq = simplify(eq)
subs(eq, o, 1)

%% 2.3



%% problem 4.1

%tf from after 1-a to output
sys = tf(1,1,1)
covar(sys,1/12)
%% 4.2

a=0.2
%tf from after a to output
sys = tf([1-a 0],[ 1 -a],1)
covar(sys,1/12) 

%replace a by 0.2 in the options given and
% and option 3 will give the same result

%% problem 6.1
Ts=0.1 

%tf from after 4.8 to u
sys = tf(1,1,Ts)

t=impulse(sys)*Ts
res = sum(abs(t)) %this is obviouly 1 since the impulse of 1 will be 1

ans = res/2 %/2 because rounding is assumed

%% 6.2

%tf from after 0.8 to the end
sys = tf([5 -4.8],[1 -0.8],Ts) %careful signs are like this

t=impulse(sys)*Ts;
res = sum(abs(t)); %this is obviouly 1 since the impulse of 1 will be 1

ans = res/2 %/2 because rounding is assumed


