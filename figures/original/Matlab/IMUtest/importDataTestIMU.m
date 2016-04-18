close all, clear all, clc
%% IMPORTANT!!!, this file needs the ImportIMU.m file to be in the same folder as it is
% Any data that has to be modified needs to be placed in the same folder

[count1, potADC1, accX11, accY11, accX21, accY21, gyroRads11, gyroRads21] = ImportIMU('sensorstestwSimon1.csv');
[count2, potADC2, accX12, accY12, accX22, accY22, gyroRads12, gyroRads22] = ImportIMU('sensorstestwSimon2.csv');
[count3, potADC3, accX13, accY13, accX23, accY23, gyroRads13, gyroRads23] = ImportIMU('sensorstestwSimon3.csv');
[count4, potADC4, accX14, accY14, accX24, accY24, gyroRads14, gyroRads24] = ImportIMU('sensorstestwSimon4.csv');

%% Test modifications
delta_T = 0.01;

ADCmin = 2.3893;
ADCmax = 1.4113e+03;
ADCequ = 640.5645;
resRadADC = (1.5769)/(ADCmax-ADCmin);   % calculates the resolution of the ADC for the potmeter

potRad1 = (potADC1-ADCequ) * resRadADC;   % set up so pot has 0 when cubli is upright
potRad2 = (potADC2-ADCequ) * resRadADC;
potRad3 = (potADC3-ADCequ) * resRadADC;
potRad4 = (potADC4-ADCequ) * resRadADC;
%% count to time
time1 = count1*0.01;        %to transform count into time
time2 = count2*0.01;
time3 = count3*0.01;
time4 = count4*0.01;

%% Accelerometer data to Angle

accAngle11 = accToAngle(accX11, accY11);
accAngle21 = accToAngle(accX21, accY21);

accAngle12 = accToAngle(accX12, accY12);
accAngle22 = accToAngle(accX22, accY22);

accAngle13 = accToAngle(accX13, accY13);
accAngle23 = accToAngle(accX23, accY23);

accAngle14 = accToAngle(accX14, accY14);
accAngle24 = accToAngle(accX24, accY24);


%% PLOT FIGURES FOR PRESENTATION, comparison of both accelerometer data

dataToPicture(time1, accAngle11, accAngle21, potRad1, 'Accelerotemer angle from IMU nr. 1', 'Accelerotemer angle from IMU nr. 2')

dataToPicture(time2, accAngle12, accAngle22, potRad2, 'Accelerotemer angle from IMU nr. 1', 'Accelerotemer angle from IMU nr. 2')

dataToPicture(time3, accAngle13, accAngle23, potRad3, 'Accelerotemer angle from IMU nr. 1', 'Accelerotemer angle from IMU nr. 2')

dataToPicture(time4, accAngle14, accAngle24, potRad4, 'Accelerotemer angle from IMU nr. 1', 'Accelerotemer angle from IMU nr. 2')


%% integration of gyro data
gyroAngle11 = gyroIntegration(gyroRads11, delta_T);
gyroAngle21 = gyroIntegration(gyroRads21, delta_T);

gyroAngle12 = gyroIntegration(gyroRads12, delta_T);
gyroAngle22 = gyroIntegration(gyroRads22, delta_T);

gyroAngle13 = gyroIntegration(gyroRads13, delta_T);
gyroAngle23 = gyroIntegration(gyroRads23, delta_T);

gyroAngle14 = gyroIntegration(gyroRads14, delta_T);
gyroAngle24 = gyroIntegration(gyroRads24, delta_T);

%% Plot of gyro data

dataToPicture(time1, gyroAngle11, gyroAngle21, potRad1, 'Gyroscope angle from IMU nr. 1', 'Gyroscope angle from IMU nr. 2')

dataToPicture(time2, gyroAngle12, gyroAngle22, potRad2, 'Gyroscope angle from IMU nr. 1', 'Gyroscope angle from IMU nr. 2')

dataToPicture(time3, gyroAngle13, gyroAngle23, potRad3, 'Gyroscope angle from IMU nr. 1', 'Gyroscope angle from IMU nr. 2')

dataToPicture(time4, gyroAngle14, gyroAngle24, potRad4, 'Gyroscope angle from IMU nr. 1', 'Gyroscope angle from IMU nr. 2')

%% Complementary section
% To be added