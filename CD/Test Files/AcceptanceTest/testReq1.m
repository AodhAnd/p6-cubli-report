%% First Requirement: Balance from equilibrium
% Using the potentiometer
data1=csvread('testReq1.csv');
T=0.01;
Kt=0.0335;
t=data1(:,1)*T;
torque=data1(:,2)*Kt;
potRad=data1(:,3);
wheel=data1(:,4);

figure(1);
plot(t,potRad);
title('Angular Position of the Frame using the Potentiometer');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 32 -0.08 0.08]);
hold off;

% Using the IMU
data1=csvread('testReq1_IMU.csv');
T=0.01;
Kt=0.0335;
t=data1(:,1)*T;
torque=data1(:,2)*Kt;
potRad=data1(:,3);
wheel=data1(:,4);
comp_angle=data1(:,5);

figure(2);
plot(t,comp_angle,'linewidth',1.2);
title('Angular Position of the Frame using the IMU');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 20 -0.1 0.1]);
hold off;