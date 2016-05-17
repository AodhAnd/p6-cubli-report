% Magnitude diagram for the LP and the HP filters

% Same cutting frequency
tau=0.5399;
s=tf('s');
HP=tau*s/(tau*s+1);
LP=1/(tau*s+1);

close all;
figure(1);
bodemag(HP,LP,HP+LP);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Bode Diagram of the Filters')
legend('High Pass Filter','Low Pass Filter','Sumation of both Filters','Location','East');
axis([0.001 5000 -9 2]);
hold off;

% Different Cutting Frequency
tau1=0.4;
tau2=0.6;

HP=tau1*s/(tau1*s+1);
LP=1/(tau2*s+1);

figure(2);
bodemag(HP,LP,HP+LP);
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
title('Bode Diagram of the Filters')
legend('High Pass Filter','Low Pass Filter','Sumation of both Filters','Location','East');
axis([0.001 5000 -9 2]);
hold off;