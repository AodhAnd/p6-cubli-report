%% Data from the real model (Beaglebone)
data=csvread('sisotool1.csv');
time=(data(:,1))*0.01;
potRad=data(:,2);
wheel=data(:,7);
i_m=data(:,4);

% Plots
figure(4);
plot(time,potRad,'linewidth',1.2);
title('Angular Position of the Frame')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 50]);

figure(5);
plot(time,wheel,'linewidth',1.2);
title('Angular Velocity of the Wheel')
xlabel('Time (s)');
ylabel('Angular velocity (rad/s)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 50]);

figure(6);
plot(time,i_m,'linewidth',1.2);
title('Current Asked to the Motor')
xlabel('Time (s)');
ylabel('Current (A)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 50]);
