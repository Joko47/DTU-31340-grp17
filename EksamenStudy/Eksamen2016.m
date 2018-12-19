%% 1
o = sym('o')
Ts=0.02

eq=0.5/((0.1*o+1)*(0.01*o+1)*o)
eq = simplify(eq)

expand(eq)


[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
ans =tf(TFnum,TFden)
c2d(ans,Ts)

%% 2
%notesbog
%% 3 
Freq = 1/0.02
aliasing = Freq-48
%% 4 
had=0.5 %always

%% 5 and 6 wtf
a=0.06
b=0.02
c=0.8
d=0.2

eq=(((a*(o/(1-o)))/(1+b*(o/(1-o))))+1) * ((1-c*o)/(1-d*o))
eq = simplify(eq)
bottom =  sym2poly(subs(eq, o, 1))
eq=(((o/(1-o)))/(1+b*(o/(1-o))))*((1-c*o)/(1-d*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 7

eq=(1/(1-0.2*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 8 ??
disp("###################################################")
disp("################## Help 8 #########################")
disp("###################################################")
nda=1
nad=nda;
2^(nad-nda) %maybe its this
%% 9
%notesbog

%% 10
%tf from e to x2
eq=(((a*(o/(1-o)))/(1+b*(o/(1-o))))+1) 
eq = simplify(eq)
answer = sym2poly(subs(eq, o, 1))

%% 11
%notesbog

%% 12
% Dz transfer function but z^-1 is 1

eq=(((a*(o/(1-o)))/(1+b*(o/(1-o))))+1) * ((1-c*o)/(1-d*o))
eq = simplify(eq)
answer =  sym2poly(subs(eq, o, 1))

%% 13 ??
% part of 13 rest on notebog
x2=1
eq=o==(x2*-0.8)+(x2+o)*0.2
solx = solve(eq,o)

%% 14

hAD = 7;
bit = 12;
range = 0.8-0;
range*(hAD/2^bit)*1000 %1000 for m to mm


%% 15
-((10-(-10))/(0.8-0)) %minus sign comes from the summation point

%% 16 to 19
%notesbog

%% 20
%notesbog

%% 21
%notesbog
%% 22
%notesbog
%% 23
Ts=1
%for after 2.2
sys=tf([2.2],1,Ts)
t = impulse(sys,Ts)
ans22=sum(abs(t))

%for after 2.1
sys=tf([2.1],[1 0 ],Ts)
t = impulse(sys,Ts)
ans21=sum(abs(t))

%for after a
a=0.8
sys=tf([-2.1*a 2.2*a 0],[1 -1 ],Ts)
impulse(sys)*Ts

disp("###################################################")
disp("################## Help 23 #########################")
disp("###################################################")

%%

% trying to cheating and getting transfer function from simulink
[A,B,C,D] = dlinmod('worstanal',1);
[num,den]= ss2tf(A,B,C,D);
sys = tf(num,den,1)
minreal(sys)
t = impulse(sys)*1
sum(abs(t))
