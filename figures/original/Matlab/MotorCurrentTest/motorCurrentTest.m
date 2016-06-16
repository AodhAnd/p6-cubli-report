close all;

% Data read out
data=csvread('currentTest.csv');
time=data(:,1)*0.01;
asked_current=data(:,2);
real_current=-data(:,3);    % The measurement has the opposite sign due to the way the current is measured

figure(1);
hold on;
scatter(time, asked_current, '.r');%,'linewidth',1.2);
scatter(time, real_current,'.b');%,'linewidth',1); 

title('Motor Current Test');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Current (A)');
legend('Asked Current','Real Current','Location','NorthWest');
axis([0 22 -4.5 4.5]);
hold off;