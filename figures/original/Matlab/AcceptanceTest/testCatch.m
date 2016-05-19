%% Second Specification: Catching Angle
T=0.01;
Kt=0.0335;

% 0.12 rad
data12=csvread('testCatch_12.csv');
t12=data12(:,1)*T;
torque12=data12(:,2)*Kt;
wheel12=data12(:,4);
comp_angle12=data12(:,5);

figure(1);
plot(t12,comp_angle12,'linewidth',1.2);
title('Angular Position of the Frame from -0.12 rad');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 4 -0.3 0.2]);
hold off;

% 0.17 rad
data17=csvread('testCatch_17.csv');
t17=data17(:,1)*T;
torque17=data17(:,2)*Kt;
wheel17=data17(:,4);
comp_angle17=data17(:,5);

figure(2);
plot(t17,comp_angle17,'linewidth',1.2);
title('Angular Position of the Frame from -0.17 rad');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 5 -0.3 0.2]);
hold off;

% 0.185 rad
data185=csvread('testCatch_185.csv');
t185=data185(:,1)*T;
torque185=data185(:,2)*Kt;
wheel185=data185(:,4);
comp_angle185=data185(:,5);

figure(3);
plot(t185,comp_angle185,'linewidth',1.2);
title('Angular Position of the Frame starting from -0.185 rad');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
axis([0 3.5 -0.3 0.8]);
hold off;
