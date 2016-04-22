% Cubli model parameters
J_w=0.601e-3;
J_f=4.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

%% Pendulum Behavior
% Data from Simulink
warning('off');
sim('bTestModel.slx');
warning('on');

% Data from the experiment
data=csvread('pendulum.csv');
time=data(61:1300,1);
time=time-data(60,1);
pot=data(61:1300,2);

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
figure(1);
hold on;
plot(nonLinModel,'k', 'linewidth', 1.2);
grid on, grid minor;
set(gca,...
    'GridLineStyle',':',...
    'GridColor', 'k',...
    'GridAlpha', .6);
plot(time,rad, 'linewidth', 1.2);
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
hold off;