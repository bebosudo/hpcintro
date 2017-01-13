close all; clear;
% A1 = load('1st_without_collapse/3.1.txt');
A2 = load('2nd_parallel-cycle/3.2.txt');
A4 = load('4th_with_collapse/3.4.txt');

N = 4096;
A2 = A2(A2(:,2)==N,:);
A4 = A4(A4(:,2)==N,:);

S2 = ones(length(A2),1);
S4 = S2;
for i=2:length(A2)
    S2(i) = A2(1,4)/A2(i,4);
    S4(i) = A4(1,4)/A4(i,4);
end

figure
hold on
plot(A2(:,1),S2,'-o','LineWidth',2)
plot(A4(:,1),S4,'-o','LineWidth',2)

legend('Collapsed','Improved with collapse','Location','northwest');

hold on
f = [0.95 1];
P = 1:A2(end,1);
S = ones(length(P),length(f));
for i = 1:length(f)
    S(:,i) = 1./(f(i)./P+1-f(i));
    plot(P,S(:,i),'k','Linewidth',2);
end

xlabel('Processors')
ylabel('Speed up')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
axis([1 16 1 16])
export_fig 'amdahl.png'
