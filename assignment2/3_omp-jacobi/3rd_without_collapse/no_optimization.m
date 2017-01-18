filename = '3.3.no_fast.txt';
M = importdata(filename);
filename = '3.3.txt';
Z = importdata(filename);

N = [Z(4,:); Z(9,:); Z(14,:); Z(19,:); Z(24,:); Z(29,:); Z(34,:); Z(39,:); Z(44,:)];

semilogx(3.*(M(1:9,2)+2).^2,10.*M(1:9,2).^2.*M(1:9,5).*10^(-6));
hold on
semilogx(3.*(N(1:9,2)+2).^2,10.*N(1:9,2).^2.*N(1:9,5).*10^(-6));


xlabel('Memory foot print (MB)')
ylabel('MFlop/s')

legend('-O3','-fast')
print('no_optimization','-dpng')