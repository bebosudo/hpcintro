filename1 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.nmk.txt'
filename2 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.nkm.txt'
filename3 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.mnk.txt'
filename4 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.mkn.txt'
filename5 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.knm.txt'
filename6 = 'matmult_out.3620027.hnode2.perm.suncc.txt.clean.kmn.txt'

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

x1 = [32 32];
x2 = [256+32 256+32];
x3 = [256+32+30720 256+32+30720];
y = [0 3000];
semilogx(x1,y,'--',x2,y,'--',x3,y,'--')

legend('nmk','nkm','mnk','mkn','knm','kmn','location','southwest')

title('Loop Interchange Sun Studio')
print('loop_interchange_Suncc','-dpng')
