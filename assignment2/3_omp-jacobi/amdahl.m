close all; clear;
A = load('1st_without_collapse/3.1.without_collapse.txt');
A10000 = A(49:end,:);


S10000 = ones(length(A10000),1);
for i=2:length(A10000)
    S10000(i) = A10000(1,4)/A10000(i,4);
end

plot(A10000(:,1),S10000)

hold on
f = [0.7 0.8 0.9 1];
S = ones(length(A10000),length(f));
for i = 1:length(f)
    S(:,i) = 1./(f(i)./A10000(:,1)+1-f(i));
    plot(A10000(:,1),S(:,i));
end

xlabel('Processors')
ylabel('Speed up')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
axis([1 32 1 32])
%export_fig 'amdahl.png'
