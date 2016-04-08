%% ---------------------- READING DATA FROM FILE --------------------------

data = csvread('PRINT_04.CSV');

time = data(:,1)+4;  %making the time Possitive
voltage = data(:,2);

%% -------------------------- PLOTTING DATA -------------------------------

for folding = true
    if exist('p','var') == 1
        set(0, 'DefaultFigurePosition', p)
    end
end %<--setting figure position

a = figure;
plot(time, voltage, 'linewidth', 1.5);
hold on;

%% ---------------------------- PLOT SETTINGS -------------------------------

%limmiting the axes
ylim([-.05 .5])
xlim([ 0 4 ])

%title and axis labels added
title('Potentiometer Test')
xlabel('Time (s)')
ylabel('Voltage (V)')

%adding legend
% legend('Angular movement in volt',...
%        'Lower limmit',...
%        'Upper limmit',...
%        'Equlibrium point',...
%        'Mid-range',...
%        'Location', 'southwest' )

%setting grid style
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)

hold off;