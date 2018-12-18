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

eq=((a*(o/(1-o))+1)/(1+b*(o/(1-o))+1))*((1-c*o)/(1-d*o))
eq = simplify(eq)
bottom =  sym2poly(subs(eq, o, 1))
eq=(((o/(1-o)))/(1+b*(o/(1-o))+1))*((1-c*o)/(1-d*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 7

eq=(1/(1-0.2*o))
eq = simplify(eq)
top = sym2poly(subs(eq, o, 1))

result = top/bottom/2

%% 8 ??

%% 9
Ts=1;
input1=[1,1,1,1,1,1]
output1=[1 1,1.5,1.87,2.1630,2.3971]


sys = tf(output1,input1,Ts)
%%

sys = tf([1 -0.8],[1 -0.2],Ts)


[z,p]=zpk(sys)%
%%
syms b1 a1 a2
eqn1 = 1.5+a1 == b1+1;
eqn2 = 1.87+ a1*1.5+a2 == b1+1;
eqn3 = 3.1630 + a1*1.87 + 1.5*a2 == b1+1;


[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [b1, a1, a2])

X = linsolve(A,B)
%%

b1=-0.5;
b1+1-1.5