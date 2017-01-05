filename1 = 'matmult_permutations_results.txt.clean.nmk.txt'
filename2 = 'matmult_permutations_results.txt.clean.nkm.txt'
filename3 = 'matmult_permutations_results.txt.clean.mnk.txt'
filename4 = 'matmult_permutations_results.txt.clean.mkn.txt'
filename5 = 'matmult_permutations_results.txt.clean.knm.txt'
filename6 = 'matmult_permutations_results.txt.clean.kmn.txt'

 A = importdata(filename1);
 B = importdata(filename2);
 C = importdata(filename3);
 D = importdata(filename4);
 E = importdata(filename5);
 F = importdata(filename6);
 
 semilogx(A(:,1),A(:,2))
 hold on
 semilogx(B(:,1),B(:,2))
 semilogx(C(:,1),C(:,2))
 semilogx(D(:,1),D(:,2))
 semilogx(E(:,1),E(:,2))
 semilogx(F(:,1),F(:,2))
 
legend('nmk','nkm','mnk','mkn','knm','kmn','location','southwest')