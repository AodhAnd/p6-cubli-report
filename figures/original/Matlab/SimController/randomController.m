%% Cubli model parameters
J_w=0.601e-3;
J_f=5.6e-3;
B_w=17.03e-6;
B_f=7.4e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

%% Nonlinearized model vs linearized one
warning('off');
sim('randomControllerSim.slx');
warning('on');

%% Angular Position Plot
figure(1);
plot(position,'linewidth',1.2);
title('Closed Loop Response with the Controller')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 0.8]);

figure(2);
plot(torque,'linewidth',1.2);
title('Closed Loop Response with the Controller')
xlabel('Time (s)');
ylabel('Torque (Nm)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
xlim([0 0.8]);
