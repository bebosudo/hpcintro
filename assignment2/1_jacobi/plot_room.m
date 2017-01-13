filename = 'results.txt';
Z = importdata(filename);
[M,N] = size(Z);

x = linspace(-1,1,M);
y = linspace(1,-1,M);
imagesc(x,y,Z)
set(gca,'Ydir','normal');
xlabel('x'); ylabel('y');
colorbar
colormap('jet')
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
export_fig 'room.png'
