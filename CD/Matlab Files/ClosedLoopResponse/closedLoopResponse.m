close all;
clear all;
clc;

%% Cubli model parameters
J_w=0.601e-3;
J_f=4.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

%% Transfer function of the system
s=tf('s');
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));
G_reduced=minreal(G);
D=10;
T=D*G_reduced/(1+D*G_reduced);
T_reduced=minreal(T)
pole(T_reduced)

%% REal vs Simulation
% Data from Simulink
warning('off');
sim('Model3.slx');
warning('on');

%Data of the real model
data=csvread('PRINT_03.CSV');
time=data(1111:2000,1)-data(1111,1);
pot=data(1111:2000,2);

Vmin=0.0039924;
Vmax=0.4705509;
equVolt=0.2174953;  
middleVolt=0.2372716;

offsetVolt = middleVolt-equVolt;
resRad = (1.5769)/(Vmax-Vmin);
rad = (pot - equVolt)*resRad;

% Plot 
figure(2);
hold on;
plot(init,'linewidth',1.2);
plot(time,rad,'linewidth',1.2);
title('Closed Loop Function');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
legend('Simulation','Real Cubli');
axis([0 2.2 -0.8 0.1]);
hold off;

