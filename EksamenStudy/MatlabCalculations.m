%% Z transform

syms t;
f = t^2;
ztrans(f)

%% Inverse Z transform

syms z;
F = (3*z^2 - 1.736*z) / (z^2 - 1.368*z + 0.368);
iztrans(F)

%% Factorization

syms z;
f = z^2 - 1.368*z + 0.368;
factor(f)

%% System of equations

syms x y;
f1 = x + y == 3;
f2 = -0.368*x - y == -1.736;
[A,B] = equationsToMatrix([f1, f2], [x, y]);
X = linsolve(A,B)

%% Motor model velocity

% Data
Ts = 0.005;
Va = 1;
Mb = 0;
R = 9.73;
L = 0;
kt = 0.0278;
ke = kt;
Jm = 24.2*10^(-7);
f = 0;
Jl = 5*10^(-4);
N = 45;

% Calculations
Jtot = Jm + Jl / N^2;
G = minreal(tf( [kt], [L*Jtot, R*Jtot, kt*ke])) % Velocity
H = c2d(G, Ts)

%% Motor model position

% Data
Vcc = 10;
Angle_deg = 352;
Angle_rad = degtorad(Angle_deg);

% Calculation
kpot = 10 / (Angle_rad)
G = minreal(tf( [kt*kpot], [N*L*Jtot, N*R*Jtot, N*kt*ke, 0])) % Position
H = c2d(G, Ts)

%% P for given closed loop pole

% H = tf([4.977], [1 -0.8616]);
Pole = -1;
syms P;
P = double(solve(4.977*P + -0.8616 == -Pole, P))

%% P given a phase margin

[m,p,w] = bode(H * D_dig, 1:0.01:100);
phase_margin =  75;
p0 = -(180 - phase_margin);
wp0 = interp1(p(:), w, p0);
mp0 = interp1(w ,m(:), wp0);
mp0_dB = mag2db(mp0);
P = 1 / (10^ (mp0_dB / 20))

%% P given a frequency

[m,p,w] = bode(G * D, 1:0.01:100);
wp0 = 165.0772;
mp0 = interp1(w, m(:), wp0);
mp0_dB = mag2db(mp0);
P = 1 / (10^ (mp0_dB / 20))

%% 0 dB Frequency of a system

[m,p,w] = bode(G*P*D, 1:0.01:100);
m0_dB = 0;
m0 = db2mag(m0_dB);
wp0 = interp1(m(:), w, m0)

%% Frequency conversion

f = 10;           % Hz
w = f * 2 * pi;   % rad / s
Ts = 1 / f;
Ts = 1 / (w/(2*pi));

%% Max gain P for stable system

[m,p,w] = bode(H, 1:0.01:100);
phase_margin = 0;
p0 = -(180 - phase_margin);
wp0 = interp1(p(:), w, p0);
mp0 = interp1(w, m(:), wp0);
mp0_dB = mag2db(mp0);
P_controller = 1 / (10^ (mp0_dB / 20))

%% Max Phase Margin

[m,p,w] = bode(H * I_dig , 1:0.01:100);      
phase_max = max(p);                     %Max fase
phase_margin = 180 + phase_max
           
%% I controller

Tao_i = 5/6.6425;
I = (tf([Tao_i 1], [Tao_i 0]))
I_dig = c2d(I, Ts, 'Tustin')

%% D controller

Tao_d = -1/-29.783;
alpha = 0.2;
D = (tf([Tao_d 1], [alpha*Tao_d 1]))
D_dig = c2d(D, Ts, 'Tustin')

%% Zero and pole of a system

zeros = zero(G)
poles = pole(G)

%% Worst Case Analysis

Ts = 1;
Ts=1
sys=tf(-[1 -0.8],[5 -4.8],Ts)
D = tf([1.9 -1.7],[1 -0.8],1);
G = tf([0.004837 0.004679],[1 -1.905 0.9048],1);
H = minreal((G) / (1 + G * D));
Impuslse_values = impulse(H) * Ts;
Sum = sum(abs(Impuslse_values));
Gain = Sum / 2

%% Sotchastic Analysis

D = tf([1.9 -1.7],[1 -0.8],1);
G = tf([0.004837 0.004679],[1 -1.905 0.9048],1);
H = minreal((D * G) / (1 + G * D));
Contribution = covar(H, 1/12)

%%

Ts = 1;
G = tf([0.1],[1 -1], Ts);
D = tf([4], [1], Ts);
K = 0.1;
R = K * tf([1 0], [1 -2 1], Ts);
limit_tf = tf([1 -1], [1], Ts);

Sys = minreal(D * G);
Sys_limit = minreal(limit_tf * Sys)

%% 

Dz = tf([-0.7 0],[1 -1.3 0.36],1);
D0_2 = tf([-0.7],[1 -1.3 0.36],1);
D0_7 = tf([1],[1 -0.4],1);

H = minreal(Dz * 2 / (1+ Dz * 10))