% Cubli model parameters
T_m=0.005;
J_w=0.601e-3;
J_f=5.6e-3;
B_w=17.03e-6;
B_f=7.4e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

%% Plot
close all;
warning('off');
sim('Model1.slx');
figure(7);
plot(init2,'linewidth',1.2);
title('Comparison of Linear and Nonlinear Models')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
legend('Linearized','Nonlinear','Location','Northwest');
axis([1.4 1.55 0.2 1]);
warning('on');
