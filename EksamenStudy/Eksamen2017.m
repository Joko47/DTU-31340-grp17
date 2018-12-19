%% 1
Ts=0.01
sys =tf([0.5],[0.04 1 0])
sys = c2d(sys,Ts)
minreal(sys)

%% 2
G0z=tf([3.3e-3 2.6e-3],[1 -1.4 0.4],0.01)
bode(G0z)

%check where phase margin is 60º (at 125)
% it is more less
gaindb = 31.5 %db


%convert db to number
res = 10^(gaindb/20)
disp("###################################################")
disp("################## Help 2 #########################")
disp("###################################################")

%% 3

disp("###################################################")
disp("################## Help 3 #########################")
disp("###################################################")
kp1=[130.1 100.43 83.9 159.4 55.2]
G0z=tf([3.3e-3 2.6e-3],[1 -1.4 0.4],Ts)
%Dz=tf(kp1*[0.1542 -0.1441],[1 -1],Ts)


%
 Dz=tf([0.1542 -0.1441],[1 -1],Ts)
 [mag,phase,wout] =    bode(G0z*Dz/(1+G0z*Dz))
 
 phase=squeeze(phase)
 maxid = find(phase ==max(phase(130:174)))
 

 wow =  mag(maxid) %index of highest phase margin
 1/wow

%
bode(G0z*Dz/(1+G0z*Dz))


gaindb = 43 %db


%convert db to number
res = 10^(gaindb/20)

%% 4
1/Ts > 2*44 %if true frequency stays the same


%% 5
hadcontrib = 0.5 %always

%% 6 DC LIMIT
o = sym('o')

eq=(1 -0.98*o)/(1-0.99*o)*((0.15*o/(1-o)+1) / (1+0.3* o/(1-o)))
eq = simplify(eq)
bottom =  sym2poly(subs(eq, o, 1))

eq=(1)/(1-0.99*o)*((0.15*o/(1-o)+1) / (1+0.3* o/(1-o)))
eq = simplify(eq)
top =  sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 7
o = sym('o')




eq=((0.15*o/(1-o)+1) / (1+0.3* o/(1-o)))
eq = simplify(eq)
top =  sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 8 
top=1 %this is the tf from the term to the end

result= top/bottom/2


%% 9

%when delta nda1 = delta nad1 - IF NOT IDK
nda=8
nad=10;
2^(nad-nda) %maybe its this

%what about the truncation and rounding bs?
%maybe because its a relative measure it doenst matter

%% 10
%notesbog
%but also here
eq=(1 -0.98*o)/(1-0.99*o)-1
eq = simplify(eq)
result =  sym2poly(subs(eq, o, 1))

%% 11
eq=(1 -0.98*o)/(1-0.99*o)
eq = simplify(eq)
result =  sym2poly(subs(eq, o, 1))

%% 12
eq=(1 -0.98*o)/(1-0.99*o)
eq = simplify(eq)
result =  sym2poly(subs(eq, o, 1))

%% 13
answer=bottom %full tf

%% 14
%notesbog

%% 15
hAD = 11;
bit = 10;
range = 1-0;
range*(hAD/2^bit)*1000 %1000 for m to mm

%% 16
-((10-(-10))/(1-0)) %- comes from the summation point

%% 17 - 19
%notesbog

%% 20
disp("###################################################")
disp("################## Help 20 #########################")
disp("###################################################")

%for b0 and AD
Ts=1
G1=tf([1 -1],[1 -0.8],Ts);
G2=tf([0.35],[1 -0.8],Ts);
%ad and
sys = G1*G2
minreal(sys)
res = impulse(sys)*Ts;
answer = sum(abs(res))/2
%%
%% for b1 and a1
G1=tf([1],[1 -0.8],Ts)
G2=tf([0.35],[1 -0.8],Ts);

sys = G1*G2
minreal(sys)
res = impulse(sys)*Ts;
answer = sum(abs(res))/2

%% 0.35
sys=tf([1],[1 -0.8],Ts);
minreal(sys)
res = impulse(sys)*Ts;
answer = sum(abs(res))/2

%% 0.6

%% 21 
%notesbog