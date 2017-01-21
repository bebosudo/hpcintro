clear; close all;
data = importdata('gpu5-bs4.txt');

A = [zeros(size(data.rowheaders)) data.data];
B = unique(data.textdata);

for i = 1:length(data.textdata)
    A(i,1) = find(strcmp(B,data.textdata{i}));
end

I = false(length(A),length(B));
for i = 1:length(B)
    I(:,i) = A(:,1) == i;
end

data = importdata('gpu5-bs8.txt');

C = [zeros(size(data.rowheaders)) data.data];
D = unique(data.textdata);

for i = 1:length(data.textdata)
    C(i,1) = find(strcmp(D,data.textdata{i}));
end

I = false(length(C),length(D));
for i = 1:length(D)
    I(:,i) = C(:,1) == i;
end

data = importdata('gpu5.txt');

E = [zeros(size(data.rowheaders)) data.data];
F = unique(data.textdata);

for i = 1:length(data.textdata)
    E(i,1) = find(strcmp(F,data.textdata{i}));
end

I = false(length(E),length(F));
for i = 1:length(F)
    I(:,i) = C(:,1) == i;
end

data = importdata('gpu5-bs32.txt');

G = [zeros(size(data.rowheaders)) data.data];
H = unique(data.textdata);

for i = 1:length(data.textdata)
    G(i,1) = find(strcmp(H,data.textdata{i}));
end

I = false(length(G),length(H));
for i = 1:length(H)
    I(:,i) = C(:,1) == i;
end
A(1:5,3) = A(1:5,3)/1000;
C(1:5,3) = C(1:5,3)/1000;
E(1:5,3) = E(1:5,3)/1000;
G(1:5,3) = G(1:5,3)/1000;
semilogx(A(1:5,2), A(1:5,3),'-o');
hold on
semilogx(C(1:5,2),C(1:5,3),'-o');
semilogx(E(1:5,2),E(1:5,3),'-o');
semilogx(G(1:5,2),G(1:5,3),'-o');

xlabel('Memory footprint [kB]'); ylabel('Performance [Gflops]');
legend('BS 4','BS 8','BS 16','BS 32','Location','southeast');
print('gpu5_blsizes','-dpng')