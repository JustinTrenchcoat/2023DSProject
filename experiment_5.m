filename='E213_hista.nc';
sst= ncread(filename,'sst_historical');
sss= ncread(filename,'sss_historical');
yrange = '[25:90]'; %latitude grid point edges determined based on the 4x5 grid
xrange = '[120:150]'; %longitude grid point edges determined based on the 4x5 grid
arr_sst = [-2 0 5 10 15 20 25 30 35]; %data range and interval based on pdd (sst)
arr_sss = [20 22 24 26 28 30 32 34 36 38 40]; %data range and interval based on pdd (sss)
sssx = sss([str2num(yrange)],[str2num(xrange)],:); %constrain to basin
sstx = sst([str2num(yrange)],[str2num(xrange)],:);
sizesss = size(sssx);
sizesst = size(sstx);
sss_reshaped = reshape(sssx,sizesss(1)*sizesss(2),660); %2091 by 660
sst_reshaped = reshape(sstx,sizesst(1)*sizesst(2),660); %2091 by 660
Xs = sss_reshaped(:,601:660);
Xt = sst_reshaped(:,601:660);
for k = 1:5
xs(:,k) = reshape(Xs(:,(12*(k-1)+1):12*(k-1)+12),12*2046,1);
xt(:,k) = reshape(Xt(:,(12*(k-1)+1):12*(k-1)+12),12*2046,1);
end
for iyear = 1:5
figure
plot(xs(:,iyear),xt(:,iyear),'x')
xlabel('SSS (psu)');
ylabel('SST (Celsius)');
title('SSS&SST distribution of Southern Atlantic Region');
end
opts = statset('Display','final');
k=4;
for iyear = 1:5
X = [xs(:,iyear),xt(:,iyear)];
[idx,C] = kmeans(X,k,'Distance','cityblock',...
'Replicates',5,'Options',opts);
%kmeans function
figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'y.','MarkerSize',12)
plot(X(idx==4,1),X(idx==4,2),'g.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','NW')
xlabel('SSS (psu)');
ylabel('SST (Celsius)');
title 'SSS&SST distribution of Southern Atlantic Region, Clustered'
hold off
end