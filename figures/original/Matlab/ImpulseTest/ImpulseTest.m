clear all
close all
clc

%% Pendulum Behavior
% Data from the experiment
data=csvread('pendulum.csv');
time=data(61:1300,1);
time=time-data(60,1);
pot=data(61:1300,2);

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
plot(time,pot, 'linewidth',1.4);
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
axis([0 12 -0.05 0.45]);
hold off;

% Plot of the position
figure(2);
hold on;
plot(time,rad, 'linewidth',1.4);
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
axis([0 12 -0.8 0.8]);
hold off;