% Cubli model parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=2.8e-3;
B_w=17.03e-6;
B_f=6.08e-3;
m_w=0.222;
m_f=0.354;
g=9.82;
l_w=0.093;
l_f=0.076;

% Transfer function of the system
s=tf('s');
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));

G_reduced=minreal(G);   % Equal poles and zeros cancelled each other

% Response of the closed loop system with P-Controller
close all;
D=1;
T=D*G_reduced/(1+D*G_reduced);

[step_r, t1]=step(T,0.3);
[impulse_r, t2]=impulse(T,0.3,'r');
title('Closed Loop Function');
hold on;
plot(t1,step_r);
plot(t2,impulse_r,'r');
legend('Step Response','Impulse Response');
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0,0.3,-1000,10]);
grid on;
hold off;

