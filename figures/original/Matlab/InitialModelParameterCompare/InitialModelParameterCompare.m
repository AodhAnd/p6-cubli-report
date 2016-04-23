clear all
close all
clc

%----- IMPORTING TEST-DATA ------------------------------------------------
testData = csvread('PRINT_03.CSV');%, 0, 0, [0 0 1500 1]);% <-- simTime=3.75
t = (testData(:,1)'+5)';
Yvolt = testData(:,2);

%Data from Volt to radians
Vmin = 0.4708;    %   mean(voltage( 667:1243,1)) %voltage mean from 3.3 to 6.2 in time
Vmax = 0.9513;    %   mean(voltage(1336:2000,1)) %voltage mean from 6.7 to 10 in time
equVolt = 0.6945; %   mean(voltage(   1: 591,1)) %voltage mean from 0 to 2.9 in time
resRad = (1.5769)/(Vmax-Vmin);
Y = (Yvolt - equVolt)*resRad-0.005;

%----- SIMULATION ---------------------------------------------------------

%Defining Cubli parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=0.8e-3;    %2.8e-3   <---initial guess parameter
B_w=17.03e-6;
B_f=6.08e-3;   %6.08e-3  <---initial guess parameter
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

u = zeros(size(Yvolt));  %<--vector of zeroes for simulation input
simIn = [ t u ];        %<--variables for simulation input

%Plot the test-data for refference
%To reposition figure window:
% - Resize figure windows and place it on the screen as you wish
% - Type get(gcf, 'position') in the terminal
% - Insert new positions below
figure('Position', [412, 313, 660, 485])

scatter(t,Y, 'r', '.')
grid on, grid minor;
title('Simulation with Initial Model Parameters')
xlabel('Time (s)')
ylabel('Angle (rad)')
hold on

%simulating and recording the output-data in Ym
warning('off');
sim('CubliParameterCompare.slx');
warning('on');
Ym = simOut;

%plot the result of each iteration
h = plot( t, Ym, 'linewidth', 1.2 );
set(h, 'color', '[ .4 0 .6 ]');

legend('Test data', 'Simulation', 'Location', 'SouthEast')