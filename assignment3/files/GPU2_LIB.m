clear; close all;
data = importdata('lib.txt');

A = [zeros(size(data.rowheaders)) data.data];
B = unique(data.textdata);

for i = 1:length(data.textdata)
    A(i,1) = find(strcmp(B,data.textdata{i}));
end

I = false(length(A),length(B));
for i = 1:length(B)
    I(:,i) = A(:,1) == i;
end

data = importdata('gpu2.txt');

C = [zeros(size(data.rowheaders)) data.data];
D = unique(data.textdata);

for i = 1:length(data.textdata)
    C(i,1) = find(strcmp(D,data.textdata{i}));
end

I = false(length(C),length(D));
for i = 1:length(D)
    I(:,i) = C(:,1) == i;
end
A(1:5,3) = A(1:5,3)/1000;
C(1:5,3) = C(1:5,3)/1000;
semilogx(A(1:5,2), A(1:5,3),'-o');
hold on
semilogx(C(1:5,2),C(1:5,3),'-o');

xlabel('Memory footprint [kB]'); ylabel('Performance [Gflops]');
legend('LIB','GPU2','Location','southeast');
print('gpu2_lib','-dpng')