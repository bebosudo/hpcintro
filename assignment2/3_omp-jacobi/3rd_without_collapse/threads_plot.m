close all
filename = '3.3.txt';
Z = importdata(filename);
A = Z(1:5,:);
B = Z(6:10,:);
C = Z(11:15,:);
D = Z(16:20,:);
E = Z(21:25,:);
F = Z(26:30,:);
G = Z(31:35,:);
H = Z(36:40,:);
I = Z(41:45,:);
semilogy(A(1:5,1),A(1:5,5));
hold on
% Nº threads -Iterations/s
%semilogy(B(1:5,1),B(1:5,5));
semilogy(C(1:5,1),C(1:5,5));
%semilogy(D(1:5,1),D(1:5,5));
semilogy(E(1:5,1),E(1:5,5));
%semilogy(F(1:5,1),F(1:5,5));
semilogy(G(1:5,1),G(1:5,5));
%semilogy(H(1:5,1),H(1:5,5));
semilogy(I(1:5,1),I(1:5,5));

xlabel('Nº Threads')
ylabel('Iter/s')

legend('N = 128','N = 512','N = 1260','N = 4096','N = 10000','location','southwest');
% Memory - MFlops/s
print('iter_threads_3','-dpng')

M = [Z(1,:); Z(6,:); Z(11,:); Z(16,:); Z(21,:); Z(26,:); Z(31,:); Z(36,:); Z(41,:)];
N = [Z(2,:); Z(7,:); Z(12,:); Z(17,:); Z(22,:); Z(27,:); Z(32,:); Z(37,:); Z(42,:)];
O = [Z(3,:); Z(8,:); Z(13,:); Z(18,:); Z(23,:); Z(28,:); Z(33,:); Z(38,:); Z(43,:)];
P = [Z(4,:); Z(9,:); Z(14,:); Z(19,:); Z(24,:); Z(29,:); Z(34,:); Z(39,:); Z(44,:)];
Q = [Z(5,:); Z(10,:); Z(15,:); Z(20,:); Z(25,:); Z(30,:); Z(35,:); Z(40,:); Z(45,:)];

figure

semilogx(3.*(M(1:9,2)+2).^2,10.*M(1:9,2).^2.*M(1:9,5).*10^(-6));
hold on
semilogx(3.*(N(1:9,2)+2).^2,10.*N(1:9,2).^2.*N(1:9,5).*10^(-6));
semilogx(3.*(O(1:9,2)+2).^2,10.*O(1:9,2).^2.*O(1:9,5).*10^(-6));
semilogx(3.*(P(1:9,2)+2).^2,10.*P(1:9,2).^2.*P(1:9,5).*10^(-6));
semilogx(3.*(Q(1:9,2)+2).^2,10.*Q(1:9,2).^2.*Q(1:9,5).*10^(-6));
xlabel('Memory foot print (MB)')
ylabel('MFlop/s')

legend('1 Thread','2 Threads','4 Threads','8 Threads','16 Threads','location','northwest')
print('memory_flops_3','-dpng')