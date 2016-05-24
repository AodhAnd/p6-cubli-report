% Cubli model parameters
T_m=0.005;
J_w=0.601e-3;
J_f=4.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;
m_w=0.222;
m_f=0.77-m_w;
g=9.82;
l_w=0.093;
l_f=0.08498;

%% Plot
close all;
warning('off');
sim('Model1.slx');
warning('on');
figure(1);
plot(init2,'linewidth',1.2);
title('Comparison of Linear and Nonlinear Models')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
legend('Linearized','Nonlinear','Location','Northeast');
%error=init2.Data(find(init2.Time(:,1)==0.6351),1)-init2.Data(find(init2.Time(:,1)==0.6351),2);
%text(0.6351,0.6,'Error 'num2str(error));

