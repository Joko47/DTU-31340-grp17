%% Exercise 3

%% 3.1.1
% Find the Z-transform for the following functions using  a sample time T=0.1 and Table D.1
% * f(t) = t^2
% * f(t) = e^(-t)-e^(0.1*t)
% * f(t) = e^(-0.2*t)*cos(4*pi*t)
T=0.1;
z = tf('z',T);

t = 0:T:T*20;
f = t.^2
stairs(t, f)

H = (T^2*z^2 +T^2*z)/(1*z^3-3*z^2+3*z-1)
stairs(impulse(H,2)*T)

%% 3.1.2
a=1;
b=0.1;
syms z
num = [exp(-a*T)-exp(-b*T) 0];
vpa(expand((z-exp(-a*T))*(z-exp(-b*T))),3)
den = [1 -1.89 +0.896];

H = tf(num,den,T)


t = 0:T:T*20;
f = exp(-a*t)-exp(-b*t).^2
stairs(t*10, f)
hold on;
stairs(impulse(H,2)*T)
hold off;

%% 3.1.3
syms t
a=0.2
z = tf('z',T)
ztrans(exp(-a*t)*cos(4*sym(pi)*t));
H = (z^2-exp(-a*T)*z*cos(4*pi*T))/(z^2-2*exp(-a*T)*z*cos(4*pi*T)+exp(-2*a*T))
[num den] = tfdata(H);
num = cell2mat(num);
den = cell2mat(den);
num = num/num(1)
den = den/den(1)


t = 0:T:T*20;
f = exp(-a*t).*cos(4*pi*t);
stairs(t*10, f)
hold on;
stairs(impulse(H,2)*T)

%% Exercise 3.2
% * f(t) = e^(a-t)-e^(b*t) using linearity rule


%% Exercise 3.3
% * find the time function for F(z) = (3*z^2-1.736*z)/(z^2-1.368*z+0.368)
%   using partial fraction expansion