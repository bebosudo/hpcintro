filename = 'results.txt';
Z = importdata(filename);
[M,N] = size(Z);

imagesc(x,y,Z)
set(gca,'Ydir','normal');
xlabel('x'); ylabel('y');
colorbar
colormap('jet')
%%
%x = linspace(-1,1,M);
%y = linspace(1,-1,M);
%[X,Y] = meshgrid(x,y);
%p = surf(X,Y,Z)
% set(p,'EdgeColor','w')
%figure
%contour(X,Y,Z)
