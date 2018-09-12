%% Exercise 4

%% 4.1.1
% Find H_zoh(z) for G(s) = 1/s
T = 0.5;
syms z
H = T/(z-1)

c2d(tf([1],[1 0]),T)
%% 4.1.2
% Find H_zoh(z) for G(s) = 1/(s*(s+1))

z = tf('z',T)
H = ((exp(-T)+T-1)*z+(1-(1+T)*exp(-T)))/((z-1)*(z-exp(-T)))

c2d(tf([1],[1 1 0]),T)

%% 4.2.1