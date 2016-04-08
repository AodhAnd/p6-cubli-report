%% Pendulum Behavior
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

% Plot of the voltage
close all;
figure(1);
hold on;
plot(time,pot, 'linewidth', 1.2);
grid on, grid minor;
set(gca,...
    'GridLineStyle',':',...
    'GridColor', 'k',...
    'GridAlpha', .6)
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on;
axis([0 12 -0.05 0.45]);
hold off;

% Plot of the position
figure(2);
hold on;
plot(time,rad, 'linewidth', 1.2);
grid on, grid minor;
set(gca,...
    'GridLineStyle',':',...
    'GridColor', 'k',...
    'GridAlpha', .6);
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
axis([0 12 -0.8 0.8]);
hold off;