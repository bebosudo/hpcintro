clear; close all;
load times.csv
plot(times(:,1),times(:,2),'-o','LineWidth',2)
xlabel('Threads')
ylabel('Wall time')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'timePlot.png'
