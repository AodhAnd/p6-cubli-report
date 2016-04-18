% Cubli model parameters
J_w=0.601e-3;
J_f=5.6e-3;%2.8e-3;
B_w=17.03e-6;
B_f=7.4e-3;%6.08e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

% Transfer function of the system
s=tf('s');
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));
%figure(1);
%rlocus(G);
G_reduced=minreal(G);   % Equal poles and zeros cancelled each other

% Comparison between G and the model in Simulink (must be the same if we
% didn't do anything wrong)
clc;
close all;
figure(1);
[step_response, t]=step(G,0.1);
plot(t,step_response);
hold on;
sim('stepComparisonSim.slx');  % Output must be Structure tith time
plot(stepResponseData.time,stepResponseData.signals.values,'.k');
title('Step Response');
xlabel('Time (s)');
ylabel('Angular Position of the Frame (rad)');
grid on;
%set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
legend('Transfer Function Response','Simulation Response','Location','Northeast');
hold off;

