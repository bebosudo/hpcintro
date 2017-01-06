filename1 = 'matmult_permutations_results.txt.clean.mnk.txt'
filename2 = 'lib.plot.txt'

 A = importdata(filename1);
 B = importdata(filename2);
 
 semilogx(A(:,1),A(:,2))
 hold on
 semilogx(B(:,1),B(:,2))

legend('nat','lib','location','southwest')