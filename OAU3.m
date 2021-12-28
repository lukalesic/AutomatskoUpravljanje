clear all
close all

%parametri
Kt = 5.77E+07;
Tt = 0.00424;
D = 0.26;
ii = 6;
J = 3.83;
Ra = 0.517;
La = 0.018;
K = 2.94;
Kf = 0.0053;
Kc = 49;
Ft0 = 1870;
v0 = 4;
du = 2.8;




%parametri u radnoj tocki
Ia0 = Ft0*D/(K*2*ii);
om0 = (2*ii/D)*v0;
ua0 = Ia0*Ra + K*om0;
u0 = ua0/Kc;
uf0 = Kf * Ft0;

%prijenosna funkcija
A = D/(2*ii);
b0 = Kc * Kf * Kt * K * A;
b1 = Kc * Kf * Kt * K * A * Tt;
n0 = Kt * Ra * A * A;
n1 = Kt * La * A * A + Kt * Ra * Tt * A * A + K * K;
n2 = J * Ra + Kt * La * Tt * A * A;
n3 = J * La;
b = [b1 b0];
n = [n3 n2 n1 n0];
G = tf(b,n)
step(G);

%vrijednosti Kr
Kr = 0.02596565;
%Kr1.2= 0.03115872;
%Kr0.6=0.01557936;

P = pole(G);
Z= zero(G);
pzplot(G)


%za zatvoreni krug

num = [0.28907*Kr 68.17857*Kr]
den = [4.9242*10^-6 2.8907*10^-4 0.0396857+Kr*0.28907 1+68.1785*Kr]
fja = tf(num, den)


%polovi i nule sve troje
%obicniKr
num1 = [0.28907*0.02596565 68.17857*0.02596565]
den1 = [4.9242*10^-6 2.8907*10^-4 0.0396857+0.02596565*0.28907 1+68.1785*0.02596565]
fja1 = tf(num, den)


%kr je 0.6Kr
numv = [0.28907*0.01557936 68.17857*0.01557936]
denv = [4.9242*10^-6 2.8907*10^-4 0.0396857+0.01557936*0.28907 1+68.1785*0.01557936]
fjav = tf(numv, denv)


%kr je 1.2Kr
numm = [0.28907*0.03115872 68.17857*0.03115872]
denm = [4.9242*10^-6 2.8907*10^-4 0.0396857+0.03115872*0.28907 1+68.1785*0.03115872]
% fjam = tf(numm, denm)
% 
% 
% pzmap(fja1, fjav, fjam);
% legend('Kr=1Kr', 'Kr=1.2Kr', 'Kr=0.6Kr')
% 
% nyquist(fja1, fjav, fjam)
% legend('Kr=1Kr', 'Kr=1.2Kr', 'Kr=0.6Kr')
% 
% 
% 



% bode i nyquist

numb = [0.28907*0.02596565 68.17857*0.02596565]
denb = [4.9242*10^-6 2.8907*10^-4 0.039685 1]

numb12 = [0.28907*0.03115872 68.17857*0.03115872]
denb12 = [4.9242*10^-6 2.8907*10^-4 0.039685 1]


numb06 = [0.28907*0.01557936 68.17857*0.01557936]
denb06 = [4.9242*10^-6 2.8907*10^-4 0.039685 1]




funkcijabode = tf(numb, denb)
funkcijabode12 = tf(numb12, denb12)
funkcijabode06 = tf(numb06, denb06)

bode(funkcijabode06, funkcijabode, funkcijabode12)

bode(funkcijabode)
margin(funkcijabode)
legend('Kr=0.6Kr', 'Kr=Kr', 'Kr=1.2Kr')

% nyquist(funkcijabode06, funkcijabode, funkcijabode12)
% legend('Kr=0.6Kr','Kr=Kr','Kr=1.2Kr')




%rad na labosu prvi zadatak

sim('PREG2018b.slx')
figure;
plot(t, uf1)
hold on
plot(ufscope)
xlabel('Vrijeme [s]')
ylabel('Sila FT [N]');
title('Za vrijednost regulatora Kr=Kr*1.2')
legend('Odziv regulacijskog kruga','Referentna vrijednost')
grid on


