clear all
close all
clc
% Getting data
%[count, potRad, accX1, accY1, accZ1, gyroRads1, compare] 
data = csvread('compFilterData1.csv');
count = data(:,1)-2;
potRad = data(:,2)+0.015;
accX1 = data(:,3);
accY1 = data(:,4);
accZ1 = data(:,5);
gyroRads1 = data(:,6);
compare = data(:,7);

T=0.01;
t = count*T;

% Plot of the raw data
% Potentiometer data
figure(2);
plot(t,potRad);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Measurements from the Potentiometer')
xlabel('Time (s)')
ylabel('Angular Position (rad)')
hold off;

% Accelerometer data
figure(3);
gravity=sqrt(accX1.^2+accY1.^2+accZ1.^2);
plot(t,accX1,t,accY1,t,accZ1,t,gravity);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Measurements from the Accelerometer')
xlabel('Time (s)')
ylabel('Linear Acceleration (m/s^2)')
legend('accX','accY','accZ','Gravity');
hold off;

% Gyro data
figure(4);
plot(t,gyroRads1);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Measurements from the Gyroscope')
xlabel('Time (s)')
ylabel('Angular Velocity (rad/s)')
hold off;

% Plot of angle calculations
% Plot of the angle calculated with the accelerometer
accAngle1 = atan(accY1./accX1);
accAngle1offset = accAngle1 + 0.84;

figure(5);
plot(t,accAngle1offset,t,potRad,'linewidth',1.2);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Angle Calculation using the Accelerometer Data')
xlabel('Time (s)')
ylabel('Angular Position (rad)')
legend('Accelerometer','Potentiometer');
hold off;

% Angle from gyroscope data
% Plot of the angle calculated with the gyro
gyro_angle=zeros(length(gyroRads1),1);
gyro_angle(1)=0;
for i=2:length(gyroRads1)
    gyro_angle(i) = gyro_angle(i-1) + T * gyroRads1(i);
end

figure(6);
plot(t,gyro_angle,t',potRad,'linewidth',1.2);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Angle Calculation using the Gyroscope Data')
xlabel('Time (s)')
ylabel('Angular Position (rad)')
legend('Gyroscope','Potentiometer');
hold off;