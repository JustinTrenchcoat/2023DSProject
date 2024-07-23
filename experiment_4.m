filename = 'E213_hista.nc';
sst = ncread(filename,'sst_historical');
sss = ncread(filename,'sss_historical');
figure Name 'sst_graph'
contourf(sst(:,:,1,1)');colorbar
title 'Global SST Graph'
figure Name 'sss_graph'
contourf(sss(:,:,1,1)',[30:0.5:40]);colorbar
title 'Global SSS Graph'

%region focus on [] by []

yrange = '[25:90]'; % latitude grid points edges determined based on the grid equator to 
xrange = '[120:150]'; %longitude grid points edges determined based on the grid 60W to 30W

arr_sst = [-2 0 5 10 15 20 25 30 35];%data range and interval based on sst data
arr_sss = [20 22 24 26 28 30 32 34 36 38 40]; % data range and interval based on sss data

sssx = sss([str2num(yrange)],[str2num(xrange)],:);
sstx = sst([str2num(yrange)],[str2num(xrange)],:);

sizesss = size(sssx);
sizesst = size(sstx);

sss_reshaped = reshape(sssx,sizesss(1)*sizesss(2),660);
sst_reshaped = reshape(sstx,sizesst(1)*sizesst(2),660);

for itime = 1:size(sss_reshaped,2)
    X = [sss_reshaped(:,itime),sst_reshaped(:,itime)];
    % hist3(X,'Edges',{arr_sss arr_sst});
    n = hist3(X,'Edges',{arr_sss arr_sst});
    nf = size(n,1);
    nc = size(n,2);
    hist2d(:,itime) = reshape(n,nf*nc,1);
end
Iterations = 10; 
%kmeans function
k=3;% 5 groups
[idx,C,sumD, D] = kmeans(hist2d',k,'Replicates',Iterations);
for ic=1:k
clust(:,:,ic)=reshape(C(ic,:),nf,nc);
end
for ic=1:k
figure
pcolor(arr_sss,arr_sst,clust(:,:,ic)'/(sum(sum(clust(:,:,ic)))));
%set(gca,'XTick',[30 32 34 36 38],'XTickLabel',{'30','32','34','36','38'})
%set(gca,'YTick',[-2 10 20 25 30],'YTickLabel',{'-2','10','20','25','30'})
c = colorbar;
%c.Ticks = [0 .05 .10 .15 .20 .25 .3];
%c.TickLabels = {'0','.05' ,'.10', '.15','.20','.25','.3'};
%caxis([0,0.3])
xlabel('SSS (psu)','FontSize',14);
ylabel('SST (Celsius)','FontSize',14);
%set(gca,'XTick',[50 200 300 400],'XTickLabel',{'50','200','300','400'},'FontSize',12);
%set(gca,'YTick',[-2 10 20 30],'YTickLabel',{'-2','10','20','30'},'FontSize',12);
end

figure Name 'all data plot ';
x1=reshape(sst_reshaped,2046*660,1); % 1350360 different data points
x2=reshape(sss_reshaped,2046*660,1); % same 
plot(x2,x1,'x')
ylabel('SST (Celsius)', 'FontSize',14);
xlabel('SSS (psu)', 'FontSize', 14);
title 'All years SSS&SST distribution'