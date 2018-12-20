%% 1
Ts=0.01
sys =tf([0.5],[0.04 1 0])
sys = c2d(sys,Ts)
minreal(sys)

%% 2 stolen from jakob
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