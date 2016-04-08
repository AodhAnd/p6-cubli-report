clear all
close all
clc

%% Vertical fall
% Data from the experiment
data=csvread('normalStepRight-17-03.csv');
time=data(451:2000,1);
time=time-data(700,1);
pot=data(451:2000,2);

% Data from Volt to rads
Vmin=0.0039924;
Vmax=0.4705509;
equVolt=0.2174953;  
middleVolt=0.2372716;

offsetVolt = middleVolt-equVolt;
resRad = (1.5769)/(Vmax-Vmin);
rad = (pot - equVolt)*resRad;

% Plot of the voltage
close all;
figure(1);
hold on;
plot(time,pot,'r', 'linewidth',1.4);
xlim([ 0 1.5 ])
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
hold off;

% Plot of the position
figure(2);
hold on;
plot(time,rad,'r', 'linewidth',1.4);
xlim([ 0 1.5 ])
ylim([ -0.8 .1 ])
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
hold off;
%% Fall from 10º

% Data from the experiment
data=csvread('10degStepRight-17-03.csv');
time=data(716:2000,1);
time=time-data(800,1);
pot=data(716:2000,2);

% Data from Volt to rads
Vmin=0.0039924;
Vmax=0.4705509;
equVolt=0.2174953;  
middleVolt=0.2372716;

offsetVolt = middleVolt-equVolt;
resRad = (1.5769)/(Vmax-Vmin);
rad = (pot - equVolt)*resRad;

% Plot of the voltage
figure(3);
hold on;
plot(time,pot,'r', 'linewidth',1.4);
xlim([ 0 1 ])
title('Fall from -10º with respect to Equilibrium Position')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
hold off;

% Plot of the position
figure(4);
hold on;
plot(time,rad,'r', 'linewidth',1.4);
xlim([ 0 1 ])
title('Fall from -10º with respect to Equilibrium Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
hold off;
warning('on');