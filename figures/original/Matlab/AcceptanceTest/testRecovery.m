%% First Specification: Recovery Angle
data1=csvread('testRecovery.csv');
T=0.01;
Kt=0.0335;
t=data1(:,1)*T;
torque=data1(:,2)*Kt;
potRad=data1(:,3);
wheel=data1(:,4);
comp_angle=data1(:,5);

figure(1);
plot(t,comp_angle,'linewidth',1.2);
title('Angular Position of the Frame');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 24 -0.3 0.2]);
hold off;