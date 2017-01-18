close all; clear;
A1 = load('3.1.txt');
A2 = load('3.2.txt');
A3 = load('3.3.txt');

N = 8192;
A1 = A1(A1(:,2)==N,:);
A2 = A2(A2(:,2)==N,:);
A3 = A3(A3(:,2)==N,:);

S1 = ones(length(A1),1);
S2 = S1;
S3 = S2;
for i=2:length(A1)
    S1(i) = A3(1,4)/A1(i,4);
    S2(i) = A3(1,4)/A2(i,4);
    S3(i) = A3(1,4)/A3(i,4);
end

figure
hold on
plot(A1(:,1),S1,'-o','LineWidth',2)
plot(A2(:,1),S2,'-o','LineWidth',2)
plot(A3(:,1),S3,'-o','LineWidth',2)

legend('Version 1','Version 2','Version 3','Location','southeast');

hold on
f = [0.7 0.6];
P = 1:A1(end,1);
S = ones(length(P),length(f));
for i = 1:length(f)
    S(:,i) = 1./(f(i)./P+1-f(i));
    plot(P,S(:,i),'k--','Linewidth',0.5);
end

xlabel('Processors')
ylabel('Speed up')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
axis([1 16 0.5 3])
print('amdahl','-dpng')
