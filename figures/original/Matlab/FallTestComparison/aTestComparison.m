close all;
clear all;
clc;

% Cubli model parameters
J_w=0.601e-3;
J_f=5.6e-3;
B_w=17.03e-6;
B_f=7.4e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

%% Vertical fall
% Data from Simulink - Linearized model fall (SIMULATION: Connect Step1)
warning('off');
sim('aTestModel.slx');
warning('on');

% Data from the experiment
data=csvread('normalStepRight-17-03.csv');
time=data(451:2000,1);
time=time-data(450,1);
pot=data(451:2000,2);

% Data from Volt to rads
Vmin=0.0039924;
Vmax=0.4705509;
equVolt=0.2174953;  
middleVolt=0.2372716;

offsetVolt = middleVolt-equVolt;
resRad = (1.5769)/(Vmax-Vmin);
rad = (pot - equVolt)*resRad;

% Plot of the position
figure(1);
hold on;
plot(time-0.7,rad,'r', 'linewidth', 1.4);
plot(linModel.time-0.08-0.7, linModel.data, 'color', [ 0 0 .5], 'linewidth', 1.4);
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
legend('Real Cubli','Non-linearized Model','Location','Northeast');
axis([ 0 1.2 -.8 .1 ]);
hold off;
%% Fall from 10º
% Data from Simulink - Linearized model fall(SIMULATION: Connect Step2)
warning('off');
sim('aTestModel.slx');
warning('on');

% Data from the experiment
data=csvread('10degStepRight-17-03.csv');
time=data(816:2000,1);
time=time-data(815,1);
pot=data(816:2000,2);

% Data from Volt to rads
Vmin=0.0039924;
Vmax=0.4705509;
equVolt=0.2174953;  
middleVolt=0.2372716;

offsetVolt = middleVolt-equVolt;
resRad = (1.5769)/(Vmax-Vmin);
rad = (pot - equVolt)*resRad;

% Plot of the position
close all;
figure(2);
hold on;
plot(time,rad, 'r', 'linewidth', 1.4);
plot(linModel.Time+0.24, linModel.Data, 'color', [ 0 0 .5], 'linewidth', 1.4);
title('Fall from -10º with respect to Equilibrium Position');
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
legend('Real Cubli','Non-linearized Model','Location','Northeast');
axis([0 1 -0.8 -0.1]);
hold off;
warning('on');

