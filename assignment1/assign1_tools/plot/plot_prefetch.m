filename1 = 'matmult_permutations_results.txt.clean.mkn.txt'
filename2 = 'matmult_out_prefetch.mkn.txt.clean.mkn.txt'

 A = importdata(filename1);
 B = importdata(filename2);
 
 semilogx(A(:,1),A(:,2))
 hold on
 semilogx(B(:,1),B(:,2))

legend('mkn','mkn-prefetch','location','southeast')