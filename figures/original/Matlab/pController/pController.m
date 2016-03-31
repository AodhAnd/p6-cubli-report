%% Response given by the simulation
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

% Data from Simulink - Closed loop of the linearized model with ref=0
close all;
warning('off');
sim('pControllerSim.slx');
warning('on');
% The step in the simulation is needed for theta to be different than 0 at
% the start. The changes in time and value makes parallel curves, don't
% affect the dynamic response.

% Import data from text file.
data=csvread('PRINT_03.csv');
time = data(:, 1);
pot = data(:, 2);

% 
time=time-time(1,1);
time=time(1400:2000,:)-time(1399);
pot=pot(1400:2000,:);

%---------------------- CONSTANT VALUES -----------------------

Vmin=0.004316370106762;
Vmax=0.466679601990048;
equVolt=0.215324792013310;  
middleVolt=0.235497986048405;

offsetVolt = middleVolt-equVolt;
resRad = (pi/2)/(Vmax-Vmin);

rad = (pot(:,1) - middleVolt + offsetVolt)*resRad;

%--------------------------- PLOT -----------------------------
plot(pResponse);
title('Closed Loop Function');
hold on;
plot(time,rad,'r');
legend('Simulation','Real Cubli');
xlabel('Time (s)');
ylabel('Angular Position (rad)');
grid on;
hold off;