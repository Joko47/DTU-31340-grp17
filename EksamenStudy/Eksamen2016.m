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

sys = tf([1],[1 1])
bode(sys)

%% 3 ?

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
disp("###################################################")
disp("################## Help 13 #########################")
disp("###################################################")

