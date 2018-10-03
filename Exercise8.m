Num=[3 -2.4];
Den=[1 -0.99];
Ts=.1
sys = tf(Num,Den,Ts)

x =step(sys);

x(1:4)


%%

