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
Vmin=0.004316370106762;
Vmax=0.466679601990048;
equVolt=0.215324792013310;  
middleVolt=0.235497986048405;

offsetVolt = middleVolt-equVolt;
resRad = (pi/2)/(Vmax-Vmin);
rad = (pot(:,1) - middleVolt + offsetVolt)*resRad;

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
Vmin=0.004316370106762;
Vmax=0.466679601990048;
equVolt=0.215324792013310;  
middleVolt=0.235497986048405;

offsetVolt = middleVolt-equVolt;
resRad = (pi/2)/(Vmax-Vmin);
rad = (pot(:,1) - middleVolt + offsetVolt)*resRad;

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