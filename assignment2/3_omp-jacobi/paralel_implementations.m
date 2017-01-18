filename = '3.1.txt';
X = importdata(filename);
filename = '3.2.txt';
Y = importdata(filename);
filename = '3.3.txt';
Z = importdata(filename);

M = [X(4,:); X(9,:); X(14,:); X(19,:); X(24,:); X(29,:); X(34,:); X(39,:); X(44,:)];
N = [Y(4,:); Y(9,:); Y(14,:); Y(19,:); Y(24,:); Y(29,:); Y(34,:); Y(39,:); Y(44,:)];
O = [Z(4,:); Z(9,:); Z(14,:); Z(19,:); Z(24,:); Z(29,:); Z(34,:); Z(39,:); Z(44,:)];

semilogx(3.*(M(1:9,2)+2).^2,10.*M(1:9,2).^2.*M(1:9,5).*10^(-6));
hold on
semilogx(3.*(N(1:9,2)+2).^2,10.*N(1:9,2).^2.*N(1:9,5).*10^(-6));
semilogx(3.*(O(1:9,2)+2).^2,10.*O(1:9,2).^2.*O(1:9,5).*10^(-6));


xlabel('Memory foot print (MB)')
ylabel('MFlop/s')

legend('Version 1','Version 2','Version 3')
print('paralel_implementations','-dpng')