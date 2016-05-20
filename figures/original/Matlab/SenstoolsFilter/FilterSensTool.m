clear all
close all
clc
%% Getting data
%[count, potRad, accX1, accY1, accZ1, gyroRads1, compare] 
data = csvread('compFilterData1.csv');
count = data(:,1)-2;
potRad = data(:,2)+0.015;
accX1 = data(:,3);
accY1 = data(:,4);
accZ1 = data(:,5);
gyroRads1 = data(:,6);
compare = data(:,7);

T = 0.01;
%% Get angle from accel measurements
accAngle1 = atan(accY1./accX1);
%gyroAngle1 = gyroIntegration(gyroRads1, delta_T);
accAngle1offset = accAngle1 + 0.84;

%% Create vector for SensTool
t = count*T;
u = [accAngle1offset, gyroRads1];
uin = [ t u ];
y = potRad;
tau=0.99;
%% Formalities for SensTool
par0 = tau;
save measSensToolCompFilter t u y %creating measTestName
process = 'SensToolCompFilter';
run mainest.m

%% Plot of the Result
Ynew = simSensToolCompFilter(u,t,pare);
plot(t,potRad,t,Ynew,'linewidth',1.2);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Final Fit for the Angular Position Measurements')
xlabel('Time (s)')
ylabel('Angular Position (rad)')
legend('Potentiometer','Complementary Filter');
hold off;
