close all
filename1 = 'matmult_permutations_results.txt.clean.mkn.txt'
filename2 = 'matmult_out_prefetch.mkn.txt.clean.mkn.txt'

A = importdata(filename1);
B = importdata(filename2);
semilogx(A(:,1),A(:,2))
hold on
x1 = [30 30];
y = [0 3000];
semilogx(B(:,1),B(:,2),x,y,'--');
 
legend('mkn','mkn-prefetch','location','southeast')