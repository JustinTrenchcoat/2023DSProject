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

arr_sst = [-2:1:35];%data range and interval based on sst data
arr_sss = [20:1:40]; % data range and interval based on sss data

sssx = sss([str2num(yrange)],[str2num(xrange)],:);
sstx = sst([str2num(yrange)],[str2num(xrange)],:);

sizesss = size(sssx);
sizesst = size(sstx);

sss_reshaped = reshape(sssx,sizesss(1)*sizesss(2),660);
sst_reshaped = reshape(sstx,sizesst(1)*sizesst(2),660);

itime = 601;
X = [sss_reshaped(:,itime),sst_reshaped(:,itime);
     sss_reshaped(:, itime+1), sst_reshaped(:,itime+1);
     sss_reshaped(:, itime+2), sst_reshaped(:,itime+2);
     sss_reshaped(:, itime+3), sst_reshaped(:,itime+3);
     sss_reshaped(:, itime+4), sst_reshaped(:,itime+4);
     sss_reshaped(:, itime+5), sst_reshaped(:,itime+5);
     sss_reshaped(:, itime+6), sst_reshaped(:,itime+6);
     sss_reshaped(:, itime+7), sst_reshaped(:,itime+7);
     sss_reshaped(:, itime+8), sst_reshaped(:,itime+8);
     sss_reshaped(:, itime+9), sst_reshaped(:,itime+9);
     sss_reshaped(:, itime+10), sst_reshaped(:,itime+10);
     sss_reshaped(:, itime+11), sst_reshaped(:,itime+11)];
%X is now a matrix with SSS and SST of year 2010

figure Name '2010plot';
plot(X(:,1), X(:,2),'x')
ylabel('SST (Celsius)', 'FontSize',14);
xlabel('SSS (psu)', 'FontSize', 14);
title 'year 2010 SSS&SST'

for itime = 1:12
    X = [sss_reshaped(:,itime+600),sst_reshaped(:,itime+611)];
    %X is the matrix that stores SST&SSS value in itime-th month of year 2010
    % hist3(X,'Edges',{arr_sss arr_sst});
    n = hist3(X,'Edges',{arr_sss arr_sst});
    nf = size(n,1);
    nc = size(n,2);
    hist2d(:,itime) = reshape(n,nf*nc,1);%hist2d is the histogram of year 2010
end


Iterations = 10; 
%kmeans function
k=6;% 6 groups
[idx,C,sumD, D] = kmeans(hist2d',k,'Replicates',Iterations);
for ic=1:k
clust(:,:,ic)=reshape(C(ic,:),nf,nc);
end
for ic=1:k
figure
pcolor(arr_sss,arr_sst,clust(:,:,ic)'/(sum(sum(clust(:,:,ic)))));

c = colorbar;

xlabel('SSS (psu)','FontSize',14);
ylabel('SST (Celsius)','FontSize',14);

title 'Cluster'
end

figure Name 'all data plot ';
x1=reshape(sst_reshaped,2046*660,1); % 1350360 different data points
x2=reshape(sss_reshaped,2046*660,1); % same 
plot(x2,x1,'x')
ylabel('SST (Celsius)', 'FontSize',14);
xlabel('SSS (psu)', 'FontSize', 14);
title 'All years SSS&SST distribution'

