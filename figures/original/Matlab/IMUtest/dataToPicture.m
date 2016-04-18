function [] = dataToPicture( time, data1, data2, potRad, title1, title2)
% Takes 2 data sources and makes a picture of it compared to check source
figure
a = subplot(2,1,1)
plot(time, data1, time, potRad, 'linewidth', 1.2), grid on, grid minor
xlabel('Time (s)')
ylabel('Radians (rad)')
title(a,title1)
b = subplot(2,1,2)
plot(time, data2, time, potRad, 'linewidth', 1.2), grid on, grid minor
xlabel('Time (s)')
ylabel('Radians (rad)')
title(b,title2)
end

