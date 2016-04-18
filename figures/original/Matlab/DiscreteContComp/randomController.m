clear all;
close all;
clc;

%% Cubli model parameters
J_w=0.601e-3;
J_f=5.6e-3;
B_w=17.03e-6;
B_f=7.4e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

% Disturbance data
disturb=0.55;   % Disturbance torque value in Nm
t_dist=0.01;    % Duration of the disturbance

%% Nonlinearized model vs linearized one
warning('off');
sim('randomControllerSim3.slx');
warning('on');

%% Angular Position Plot
figure(1);
plot(positionComp,'linewidth',1.2);
title('Closed Loop Response in Position')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.5]);
legend('Continuous controller','Discrete controller');

figure(2);
plot(torqueComp,'linewidth',1.2);
title('Closed Loop Response in Torque')
xlabel('Time (s)');
ylabel('Torque (Nm)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.5]);
legend('Continuous controller','Discrete controller');

figure(3);
plot(wheelComp,'linewidth',1.2);
title('Closed Loop Response in the Wheel')
xlabel('Time (s)');
ylabel('Angular velocity (rad/s)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.5]);
legend('Continuous controller','Discrete controller');
