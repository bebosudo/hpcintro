clear; close all;
jacobiFast = load('1_jacobi/jacobiWithFast.txt');
jacobiNoFast = load('1_jacobi/jacobiNoFast.txt');
gaussFast = load('2_gauss/gaussWithFast.txt');
gaussNoFast = load('2_gauss/gaussNoFast.txt');

figure
semilogx(jacobiFast(:,1),jacobiFast(:,4),jacobiNoFast(:,1),jacobiNoFast(:,4),gaussFast(:,1),gaussFast(:,4),gaussNoFast(:,1),gaussNoFast(:,4))
xlabel('N'); ylabel('iter/s');
legend('Jacobi with fast','Jacobi','Gauss with fast','Gauss');
axis([1e1 1e3 0 3e6]);
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'seqCompare.png'
