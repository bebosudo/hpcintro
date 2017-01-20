clear; close all;
data = importdata('files/all_results.txt');

A = [zeros(size(data.rowheaders)) data.data];
C = unique(data.textdata);

for i = 1:length(data.textdata)
    A(i,1) = find(strcmp(C,data.textdata{i}));
end

I = false(length(A),length(C));
for i = 1:length(C)
    I(:,i) = A(:,1) == i;
end

A(:,3) = A(:,3)/1000;

% memory footprint vs flops
figure;
loglog(A(I(:,2),2),A(I(:,2),3),'-o',A(I(:,3),2),A(I(:,3),3),'-o',A(I(:,4),2),A(I(:,4),3),'-o',A(I(:,5),2),A(I(:,5),3),'-o',A(I(:,6),2),A(I(:,6),3),'-o','LineWidth',2);
xlabel('Memory footprint [kB]'); ylabel('Performance [Gflops]');
%axis([1e3 1e7 0 800]);
legend(C{2}, C{3}, C{4}, C{5}, C{6},'Location','southwest');
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'MatrixMemVsFlops.png'