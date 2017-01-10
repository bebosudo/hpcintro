close all
filename1 = '100.txt'
filename2 = 'matmult_out.perm.gcc.txt.clean.mkn.txt'

 A = importdata(filename1);
 B = importdata(filename2);
 
 semilogx(A(:,1),A(:,2))
 hold on
 semilogx(B(:,1),B(:,2))
x1 = [32 32];
x2 = [256+32 256+32];
x3 = [256+32+30720 256+32+30720];
y = [1200 3000];
semilogx(x1,y,'--',x2,y,'--',x3,y,'--')

legend('blk','nat','location','southwest')

title('Loop Blocking / Native')
print('block_nat','-dpng')