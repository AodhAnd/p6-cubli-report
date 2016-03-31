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
Vmin=0.004316370106762;
Vmax=0.466679601990048;
equVolt=0.215324792013310;  
middleVolt=0.235497986048405;

offsetVolt = middleVolt-equVolt;
resRad = (pi/2)/(Vmax-Vmin);
rad = (pot(:,1) - middleVolt + offsetVolt)*resRad;

% Plot of the position
close all;
figure(1);
hold on;
plot(nonLinModel,'k');
plot(time,rad);
title('Pendulum Behavior')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
hold off;