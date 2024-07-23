filename = 'E213_hista.nc';
sst = ncread(filename,'sst_historical');
sss = ncread(filename,'sss_historical');

sst_new = sst(100:180,15:100,:,:);
sst_annual=squeeze(mean(sst_new,3));
sst_overall = squeeze(mean(sst_annual,3));

sss_new = sss(100:180,15:100,:,:);
sss_annual=squeeze(mean(sss_new,3));
sss_overall = squeeze(mean(sss_annual,3));


figure Name 'sst_graph'
contourf(sst_overall',[-2:1:35]);colorbar
ylabel('Latitude', 'FontSize',10);
xlabel('Longitude', 'FontSize', 10);
title 'SST Graph of Southern Atlantic Ocean Region'

figure Name 'sss_graph'
contourf(sss_overall',[20:0.5:40]);colorbar
ylabel('Latitude', 'FontSize',10);
xlabel('Longitude', 'FontSize', 10);
title 'SSS Graph of Southern Atlantic Ocean Region'