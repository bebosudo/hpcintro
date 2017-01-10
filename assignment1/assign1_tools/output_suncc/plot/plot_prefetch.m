close all
filename1 = 'matmult_out.fetchlevel3.3618782.hnode2.txt'
filename2 = 'matmult_out.nofetch.3619246.hnode2.txt'

A = importdata(filename1);
B = importdata(filename2);
semilogx(A(:,1),A(:,2))
hold on
semilogx(B(:,1),B(:,2));

x1 = [32 32];
x2 = [256+32 256+32];
x3 = [256+32+30720 256+32+30720];
y = [1400 2600];
semilogx(x1,y,'--',x2,y,'--',x3,y,'--')
 
legend('prefetch level3','no prefetch','location','southeast')

title('Prefetch / No Prefetch')
print('Prefetch','-dpng')