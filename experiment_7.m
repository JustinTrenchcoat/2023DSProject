filename = 'E213_hista.nc';
sst = ncread(filename,'sst_historical');
sss = ncread(filename,'sss_historical');

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

itime = 599;
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

Iterations = 10; 
%kmeans function
k=3;% 3 groups
[idx,C,sumD, D] = kmeans(X,k,'Replicates',Iterations);

figure Name 'all data plot ';
x1=reshape(sst_reshaped,2046*660,1); % 1350360 different data points
x2=reshape(sss_reshaped,2046*660,1); % same 
plot(x2,x1,'x')
ylabel('SST (Celsius)', 'FontSize',14);
xlabel('SSS (psu)', 'FontSize', 14);
title 'All years SSS&SST distribution'



figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'g.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'b.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
    'MarkerSize',15,'Linewidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

