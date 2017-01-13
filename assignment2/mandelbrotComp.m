clear; close all;
mandel = load('mandelbrot.txt');
poisson = load('3_omp-jacobi/4th_with_collapse/3.4.txt');

N = 4096;
poisson = poisson(poisson(:,2)==N,:);

mandelS = ones(length(mandel),1);
poissonS = mandelS;

for i=2:length(mandel)
    mandelS(i) = mandel(1,2)/mandel(i,2);
    poissonS(i) = poisson(1,4)/poisson(i,4);
end


figure
hold on
plot(mandel(:,1),mandelS,'-o','LineWidth',2)
plot(poisson(:,1),poissonS,'-o','LineWidth',2)

legend('Mandelbrot','Poisson','Location','northwest');

xlabel('Processors')
ylabel('Speed up')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
axis([1 16 1 16])
export_fig 'mandelbrotComp.png'
