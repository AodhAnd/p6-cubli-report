%% Data from the real model (Beaglebone)
data=csvread('sisotcontrollertest5.csv');
time=(data(1:189,1))*0.01;
potAdc=data(1:189,2);
torque=data(1:189,5)*0.0335;
tachAdc=data(1:189,4);

% Conversion from ADC values (mV of the potentiometer) to rad
ADCmin = 2.389312977099237;
ADCmax = 1.411348314606742e+03;
ADCequ = 6.405645161290323e+02;
resRadADC = (1.5769)/(ADCmax-ADCmin);
potRad = (potAdc - ADCequ)*resRadADC;

% Conversion from the tachometer
tachRads = (tachAdc - 882)*0.240734983;

% Plots
figure(4);
plot(time,potAdc,'linewidth',1.2);
title('Closed Loop Response of the Real Cubli')
xlabel('Time (s)');
ylabel('Angular position (ADC values)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.9]);

figure(5);
plot(time,potRad,'linewidth',1.2);
title('Closed Loop Response of the Real Cubli')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.9]);

figure(6);
plot(time,torque,'linewidth',1.2);
title('Closed Loop Response of the Real Cubli')
xlabel('Time (s)');
ylabel('Torque of the motor (Nm)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.9]);

figure(7);
plot(time,tachRads,'linewidth',1.2);
title('Closed Loop Response of the Real Cubli')
xlabel('Time (s)');
ylabel('Angular velocity of the wheel (rad/s)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 1.9]);