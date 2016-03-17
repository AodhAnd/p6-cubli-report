% Cubli model parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=2.8e-3;
B_w=17.03e-6;
B_f=6.08e-3;
m_w=0.222;
m_f=0.354;
g=9.82;
l_w=0.093;
l_f=0.076;

% Plot
close all;
warning('off');
sim('Model.slx');
figure(7);
plot(init2);
title('Comparison of Linear and Nonlinear Models')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
%set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
legend('Linearized','Nonlinear','Location','Northwest');
axis([1.3 1.6 0 2.5]);
warning('on');
