clear; close all;
mandel = load('mandelbrot.txt');
poisson = load('3_omp-jacobi/4th_with_collapse/3.4.txt');
poisson = A2(A2(:,2)==N,:);

figure
hold on
plot(mandel(:,1),mandel(:,2),'-o','LineWidth',2)
%plot(poisson(:,1),poisson(:,2),'-o','LineWidth',2)
xlabel('Threads')
ylabel('Wall time')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
%export_fig 'timePlot.png'
