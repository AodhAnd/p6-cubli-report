close all;
clc;

%-- Controller definition --%
D=-4583.5*(s+9.483)*(s+1.599)/((s-5.539)*(s+100)*(s+200));

%-- Bode plot --%
figure
b2 = bodeplot(D);
p2 = getoptions(b2);
p2.PhaseMatching = 'on';
p2.PhaseMatchingFreq = 0;
p2.PhaseMatchingValue = 0;
setoptions(b2,p2);
grid on;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
axes_handles = findall(gcf, 'type','axes' );
legend('Continuous controller');