


num = [1.9 -1.7];
den = [1 -0.8];

Dz = tf(num,den,1);

%%


Gz0=tf([0.004837 0.004679],[1 -1.905 0.9048],1)

%2.1 Contribution AD converter

%% 2.1 and 2.2

%min real cuts poles and zeros that cancel out
sys = minreal(Dz*Gz0/(1+Dz*Gz0))

covar(sys,1/12)

%% 2.3, 2.4, 2.5

sys = minreal(Gz0/(1+Dz*Gz0))

covar(sys,1/12)

%% 3.1

%min real cuts poles and zeros that cancel out
sys = minreal(Dz*Gz0/(1+Dz*Gz0))

covar(sys,1/12)

%% 3.2 3.3 and 3.4

Dzhalf=tf([1],[1 -0.8],1)

sys = minreal(Dzhalf*Gz0/(1+Dz*Gz0))

covar(sys,1/12)

%% 3.5

Dzhalf=tf([1],[1 -0.8],1)

sys = minreal(Gz0/(1+Dz*Gz0))

covar(sys,1/12)