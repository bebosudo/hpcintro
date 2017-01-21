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

semilogx(A(1:5,2), A(1:5,3));
hold on
semilogx(A(8:12,2),A(8:12,3));

xlabel('Memory footprint [kB]'); ylabel('Performance [Gflops]');
% legend(,'Location','southwest');