clear all
close all
clc

% Cubli model parameters
J_w=0.601e-3;
J_f=5.6e-3;
B_w=17.03e-6;
B_f=7.4e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

% Transfer function of the system
s=tf('s');
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));
G_reduced=minreal(G);   % Equal poles and zeros cancelled each other

% Transfer function of the controller
D=-4583.5*(s+9.483)*(s+1.599)/((s-5.539)*(s+100)*(s+200))/0.62737;

% Analysis in the s-domain
rlocus(D*G_reduced);
set(findall(gcf,'Type','line','color','b'), 'LineWidth', 1.4)
set(findall(gcf,'Type','line','color','[0 0.5 0]'), 'LineWidth', 1.4)
set(findall(gcf,'Type','line','color','r'), 'LineWidth', 1.4)

axis([-15 15 -12 12]);
set(gca,'XGrid', 'on', 'XMinorGrid', 'on', 'YGrid', 'on', 'YMinorGrid', 'on')
set(gca, 'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
