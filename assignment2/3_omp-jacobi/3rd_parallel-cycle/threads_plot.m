filename = '3rd_version.shorts.csv';
Z = importdata(filename);
A = Z(1:6,:);
B = Z(7:12,:);
C = Z(13:18,:);
D = Z(19:24,:);
E = Z(25:30,:);
semilogy(A(1:6,1),A(1:6,5));
hold on
% Nº threads -Iterations/s
semilogy(B(1:6,1),B(1:6,5));
semilogy(C(1:6,1),C(1:6,5));
semilogy(D(1:6,1),D(1:6,5));
semilogy(E(1:6,1),E(1:6,5));
% Memory - MFlops/s
M = [Z(1,:); Z(7,:); Z(13,:); Z(19,:); Z(25,:)];
N = [Z(2,:); Z(8,:); Z(14,:); Z(20,:); Z(26,:)];
O = [Z(3,:); Z(9,:); Z(15,:); Z(21,:); Z(27,:)];
P = [Z(4,:); Z(10,:); Z(16,:); Z(22,:); Z(28,:)];
Q = [Z(5,:); Z(11,:); Z(17,:); Z(23,:); Z(28,:)];
R = [Z(6,:); Z(12,:); Z(18,:); Z(24,:); Z(30,:)];
figure
semilogx(M(1:5,2),M(1:5,5));
hold on
semilogx(N(1:5,2),N(1:5,5));
semilogx(O(1:5,2),O(1:5,5));
semilogx(P(1:5,2),P(1:5,5));
semilogx(Q(1:5,2),Q(1:5,5));
semilogx(R(1:5,2),R(1:5,5));

