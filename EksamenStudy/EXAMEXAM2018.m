%% 1
Ts=0.02


z = sym('z')

eq=1.5/((0.25*z+1)*(0.1*z+1))
eq = simplify(eq)

expand(eq)



[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
answer =tf(TFnum,TFden)
c2d(answer,Ts)

%% 2

sysd = tf([0.01448 0.01289],[1 -1.684 0.7047],Ts)



T= Ts;

deltaw=logspace(0,3,10000);
[m,p,w]=bode(sysd,deltaw);

index = find(p <= -120,1);
mag = m(index);
Kp = 1/mag

%bode(sysd)

%% 3

G0z = tf([0.01448 0.01289],[1 -1.684 0.7047],Ts)


Dz=tf([1 -0.9503],[1 -1],Ts);

sysd = G0z*Dz

T= Ts;

deltaw=logspace(0,3,10000);
[m,p,w]=bode(sysd,deltaw);

index = find(p <= -120,1);
mag = m(index);
Kp = 1/mag
%% 4
50-46

%% 5  0.9 term
z=sym('z')

inside = 0.8*z/(1-z);
eq=(0.5*inside+1)/(1+inside) * (1-0.9*z)/(1-0.95*z)
eq = simplify(eq)
bottom =  sym2poly(subs(eq, z, 1))

top = 1

top/bottom/2

%% 6  - had cheeky bastard switched the first one
0.5 % always

%% 0.5 term

eq = (1-0.9*z)/(1-0.95*z)
eq = simplify(eq)
top =  sym2poly(subs(eq, z, 1))
top/bottom/2

%%  10 -13 4 questions

%% 12 - x3
eq=((0.5*inside+1)/(1+inside))*(1/(1-0.95*z))
eq = simplify(eq)
res =  sym2poly(subs(eq, z, 1))
%% 13 - x3
eq=(0.5*inside+1)/(1+inside)
eq = simplify(eq)
res =  sym2poly(subs(eq, z, 1))


%% 14
hAD = 16;
bit = 10;
range = 0.5-0;
range*(hAD/2^bit)*1000 %1000 for m to mm

%% 15
-((10-(-10))/(0.5-0)) %minus sign comes from the summation point

%% 17
k1=3;
k2=0.6;
k3=0.6;
k4=0.1;
integ=z/(1-z) %or 1/(1-z) 

z = sym('z')

first=k4*integ+1
second=k1/(1+integ*k3*z)+integ*z*k2;
eq=first*second
eq = simplify(eq)

expand(eq)



[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
answer =tf(TFnum,TFden,Ts)
minreal(answer)

%%

k1=0.3;
k2=0.15;

integ=z %or 1/(1-z) 



z = sym('z')
eq=1/(1-k2*z)*(1+z*k1)


[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
answer =tf(TFnum,TFden,Ts)
minreal(answer)
%% 18

b0=1.5

%%
sys = tf([1.5 -1.4],[1 -0.9],1)
t = step(sys)


%% 20
sys = tf(1,1,Ts)
covar(sys,1/12)


%%

k1=0.3;
k2=0.15;

z = sym('z')

first=(1-z)/(1-z+k1)
second=k2/(1-z+k1)
eq=first+second
eq = simplify(eq)

expand(eq)

[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
answer =tf(TFnum,TFden,Ts)
minreal(answer)


%%
k1=3;
k2=-0.6;
k3=+0.6;
k4=-0.1;


z = sym('z')

before=1+k4/(1-z)

first=(1-k1*z)/(1-z+k3)
second=k2/(1-z+k3)
eq=before *(first+second)
eq = simplify(eq)

expand(eq)

[symNum,symDen] = numden(eq) %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
answer =tf(TFnum,TFden,Ts)
minreal(answer)

%%

clc;

k1 = 3;
k2 = 0.6;
k3 = 0.6;
k4=0.1;
d1 = 0;
d2 = 0;
i1=0;
i2=0;
e = 0;
f = 0;
u = 0;
u1=0;
intg = 0;

  for i=1:8
  
    e = 1;
    u1=e+i1;
    f=u1-d1;
    u(i) = k1*f+d2;
    
    i1=i1+k4*e;
    i2=i2+f;
    d1=k2*i2
    d2=k3*12
  end
 u
dz0 = tf([2.8 -4.44 1.76],[1 -1.5 0.5],1);
dz1 = tf([3 -4.8 1.92],[1 -1.6 0.6],1);
dz2 = tf([3 -4.6 1.76],[1 -1.7 0.7],1);
dz3 = tf([3 -4.6 1.76],[1 -1.6 0.63],1);
dz4 = tf([3 -5.1 2.16],[1 -1.4 0.4],1);


output1 = step(dz0,7);
output2 = step(dz1,7);
output3 = step(dz2,7);
output4 = step(dz3,7);
output5 = step(dz4,7);
ans1 = round(u-output1.',2)
ans2 = round(u-output2.',2)
ans3 = round(u-output3.',2)
ans4 = round(u-output4.',2)
ans5 = round(u-output5.',2)



