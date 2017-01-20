close all; clear; 

% Define functions
mem = @(N) 3*(N+2).^2*8./1e3;
flops = @(N,k,t) 2*k.*N.^2*6./t/1e9;
bandwidth = @(N,k,t) 2*3*k.*N.^2*8./t/1e9;


A7 = load('7/gpu1282574.out');
A8 = load('8/gpu1282576.out');
A9 = load('9/gpu1282578.out');
Aomp = load('omp/cpuOMP1283036.out');

% Add memory footprint column
A7 = [A7 mem(A7(:,1))];
A8 = [A8 mem(A8(:,1))];
A9 = [A9 mem(A9(:,1))];
Aomp = [Aomp mem(Aomp(:,1))];

% Add flops column
A7 = [A7 flops(A7(:,1),A7(:,2),A7(:,3))];
A8 = [A8 flops(A8(:,1),A8(:,2),A8(:,3))];
A9 = [A9 flops(A9(:,1),A9(:,2),A9(:,3))];
Aomp = [Aomp flops(Aomp(:,1),Aomp(:,2),Aomp(:,3))];

% Add speedup column
A7 = [A7 Aomp(1:8,3)./A7(:,3)];
A8 = [A8 Aomp(:,3)./A8(:,3)];
A9 = [A9 Aomp(:,3)./A9(:,3)];

% Add bandwidth column
A7 = [A7 bandwidth(A7(:,1),A7(:,2),A7(:,3))];
A8 = [A8 bandwidth(A8(:,1),A8(:,2),A8(:,3))];
A9 = [A9 bandwidth(A9(:,1),A9(:,2),A9(:,3))];

% memory footprint vs flops
figure;
semilogx(A7(:,4),A7(:,5),'-o',A8(:,4),A8(:,5),'-o',A9(:,4),A9(:,5),'-o',Aomp(:,4),Aomp(:,5),'-o','LineWidth',2);
xlabel('Memory footprint [kB]'); ylabel('Performance [Gflops]');
axis([1e0 1e7 0 150]);
legend('Single thread','2D block, 2D grid','Multi GPU','OpenMP','Location','northwest');
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
%export_fig 'memVsFlops.png'

% memory footprint vs speedup
figure;
semilogx(A7(:,4),A7(:,6),'-o',A8(:,4),A8(:,6),'-o',A9(:,4),A9(:,6),'-o',[1e0 1e7],[1 1],'--k','LineWidth',2);
xlabel('Memory footprint [kB]'); ylabel('Speedup (CPU/GPU)');
axis([1e0 1e7 0 10]);
lh = legend('Single thread','2D block, 2D grid','Multi GPU','Reference');
set(lh,'color','none');
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'memVsSpeedup.png'


% memory footprint vs bandwidth
figure;
semilogx(A7(:,4),A7(:,7),'-o',A8(:,4),A8(:,7),'-o',A9(:,4),A9(:,7),'-o','LineWidth',2);
xlabel('Memory footprint [kB]'); ylabel('Bandwidth [GB/s]');
axis([1e0 1e7 0 600]);
legend('Single thread','2D block, 2D grid','Multi GPU','Location','northwest');
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'memVsBandwidth.png'