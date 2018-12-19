%% P1

% 1.1 


num = [1.9 -1.7];
den = [1 -0.8];

Dz = tf(num,den,1);


res = impulse(Dz)*1;

plot(res)
answer = sum(abs(res)) /2

% 1.2 
0.5

%% P2

numG0 = [0.004837 0.004679];
denG0 = [1 -1.905 0.9048];

Gz0 = tf(numG0,denG0,1);


%% 2.1) and 2.2) (summation point is the same for both, is the same as giving a ref input)

%transfer function from beginning to u with Gain 1 as feedback loop
sys= (Gz0*Dz)/(1+Dz*Gz0)

res = impulse(sys);
plot(res)
answer = sum(abs(res))/2


%% 2.3) and 2.4) and 2.5)

%transfer function from before G0(z)  to u with Dz in feedback loop
sys= (Gz0)/(1+Dz*Gz0)

res = impulse(sys);
plot(res)
answer = sum(abs(res))/2


%% P3
% Dz is the same but is not on canonical realization now.

%3.1)
%transfer function from beginning to u with Gain 1 as feedback loop
sys= (Gz0*Dz)/(1+Dz*Gz0)

res = impulse(sys);
plot(res)
answer = sum(abs(res))/2


%% 3.2) 3.3) and 3.4)
D08=tf([1],[1 -0.8],1);


sys= (D08*Gz0)/(1+Dz*Gz0)

res = impulse(sys);
plot(res);
answer = sum(abs(res))/2

%% 3.2) 3.3) and 3.4)
D08=tf([1],[1 -0.8],1);
FB=tf([1.9 -1.7],[1],1);

sys= (D08*Gz0)/(1+D08*Gz0*FB)
sys = minreal(sys)
res = impulse(sys);
plot(res);
answer = sum(abs(res))/2



%% 3.5) same as before since TF donest change
sys= (Gz0)/(1+Dz*Gz0)

res = impulse(sys);
plot(res)
answer = sum(abs(res))/2


%%

D08=tf([1],[1 -0.8],1)

res = step(D08)

plot(res)

%   0.2942
%   3.0752





















