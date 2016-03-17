% Cubli model parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=(2.8e-3);
B_w=17.03e-6;
B_f=6.08e-3;
m_w=0.222;
m_f=0.354;
g=9.82;
l_w=0.093;
l_f=0.076;

%% Vertical fall
% Data from the experiment
data=csvread('normalStepRight-17-03.csv');
time=data(451:2000,1);
time=time-data(450,1);
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
plot(time,pot,'r');
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on;
hold off;

% Plot of the position
figure(2);
hold on;
plot(time,rad,'r');
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;

hold off;
%% Fall from 10º

% Data from the experiment
data=csvread('10degStepRight-17-03.csv');
time=data(916:2000,1);
time=time-data(915,1);
pot=data(916:2000,2);

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
figure(3);
hold on;
plot(time,pot,'r');
title('Fall from Equilibrium Position')
xlabel('Time (s)');
ylabel('Potentiometer measurement (V)');
grid on;
hold off;

% Plot of the position
figure(4);
hold on;
plot(time,rad,'r');
title('Fall from -10º with respect to Equilibrium Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
hold off;
warning('on');