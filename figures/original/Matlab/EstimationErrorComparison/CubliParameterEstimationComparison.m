close all;
clear all;
clc;

%% Cubli model parameters
J_w=0.601e-3;
B_w=17.03e-6;
m_w=0.222;
m_f=0.77-m_w;
g=9.82;
l_w=0.093;
l_f=0.08498;

%% Data
pendulumData = csvread('PRINT_03.CSV');
%simulation time: 3.5
%initial condition: 0.1487

%for the last part of the signal:
t = pendulumData(1:1401,1)'+5;
%for whole signal:
%t = pendulumData(:,1)'+10-.72;

Yvolt = pendulumData(1:1401,2);

u = zeros(size(Yvolt));
uin = [ t' u ];

% Data from Volt to rads
Vmin = 0.4708;%   mean(voltage( 667:1243,1)) %voltage mean from 3.3 to 6.2 in time
Vmax = 0.9513;%   mean(voltage(1336:2000,1)) %voltage mean from 6.7 to 10 in time
equVolt = 0.6945;%mean(voltage(   1: 591,1)) %voltage mean from 0 to 2.9 in time
resRad = (1.5769)/(Vmax-Vmin);
y = (Yvolt - equVolt)*resRad-0.005;

%% Senstool Parameters
J_f=0.0048;
B_f=0.0077;

Ym = simCubli(u,t,[ B_f J_f ]);
errn = sqrt(sum((y-Ym).^2)/sum(y.^2))*100;

figure(1);
plot(t', y, 'b');
hold on;
plot(t', Ym, 'r', 'LineWidth', 1.4);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
title('Parameter Estimation using Senstools');
xlabel('Time (s)');
ylabel('Angle (rad)');
errorSTR = ['Normed RMS Error = ', num2str(errn), ' %'];
tex = text(0.52, 0.13,        ...
               errorSTR,              ...
               'Color', '[ 0 .55 0 ]',...
               'FontSize', 12);

hold off;


%% Own Optimization Parameters
J_f=0.0048;
B_f=0.0078;

Ym = simCubli(u,t,[ B_f J_f ]);
errn = sqrt(sum((y-Ym).^2)/sum(y.^2))*100;

figure(2);
plot(t', y, 'b');
hold on;
plot(t', Ym, 'r', 'LineWidth', 1.4);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
title('Parameter Estimation using Line Search');
xlabel('Time (s)');
ylabel('Angle (rad)');
errorSTR = ['Normed RMS Error = ', num2str(errn), ' %'];
tex = text(0.52, 0.13,        ...
               errorSTR,              ...
               'Color', '[ 0 .55 0 ]',...
               'FontSize', 12);

hold off;