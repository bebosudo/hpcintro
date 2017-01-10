close all
filename1 = '5.txt'
filename2 = '10.txt'
filename3 = '50.txt'
filename4 = '100.txt'
filename5 = '150.txt'

 A = importdata(filename1);
 B = importdata(filename2);
 C = importdata(filename3);
 D = importdata(filename4);
 E = importdata(filename5);
 
 semilogx(A(:,1),A(:,2))
 hold on
 semilogx(B(:,1),B(:,2))
 semilogx(C(:,1),C(:,2))
 semilogx(D(:,1),D(:,2))
 semilogx(E(:,1),E(:,2))

x1 = [32 32];
x2 = [256+32 256+32];
x3 = [256+32+30720 256+32+30720];
y = [1000 2500];
semilogx(x1,y,'--',x2,y,'--',x3,y,'--')

legend('5','10','50','100','150','location','southeast')

title('Block sizes GCC')
print('block_sizes_gcc','-dpng')
