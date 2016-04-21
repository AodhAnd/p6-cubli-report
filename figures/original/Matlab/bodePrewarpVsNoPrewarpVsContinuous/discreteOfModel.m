close all;
clc;

% Cubli model parameters
J_w=0.601e-3;
J_f=4.8e-3;%2.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;%6.08e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

s=tf('s');
T=1/100;%1/100;

D=-4583.5*(s+9.483)*(s+1.599)/((s-5.539)*(s+100)*(s+200));
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));
G_reduced=minreal(G);

Gz=c2d(G_reduced,T,'tustin');

Dz=c2d(D,T,'tustin')
% Look at wp = 38.351 or 33.27356999 or in between
opts = c2dOptions('Method', 'tustin', 'PrewarpFrequency', 33.5);
Dz2 = c2d(D,T,opts)

bodeplot(D,Dz,Dz2);
grid on;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
axes_handles = findall(gcf, 'type','axes' );
legend(axes_handles(3),'Continuous controller','Discretized Controller (Tustin)','Discretized Controller (Tustin with Pre-Warping)','Location','Southeast');

figure
bodeplot(D*G_reduced/(1+D*G_reduced),Dz*Gz/(1+Dz*Gz),Dz2*Gz/(1+Dz2*Gz));
grid on;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
axes_handles = findall(gcf, 'type','axes' );
legend(axes_handles(3),'Continuous controller (CL)','Discretized Controller (Tustin)(CL)','Discretized Controller (Tustin with Pre-Warping)(CL)','Location','Southeast');

figure
bodeplot(D*G_reduced,Dz*Gz,Dz2*Gz);
grid on;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
axes_handles = findall(gcf, 'type','axes' );
legend(axes_handles(3),'Continuous controller (OL)','Discretized Controller (Tustin)(OL)','Discretized Controller (Tustin with Pre-Warping)(OL)','Location','Southeast');

%nyqlog(D*G_reduced);
%nyquist(Gz*Dz);
%rlocus(D*G);