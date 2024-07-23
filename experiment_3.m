Filename='E213_hista.nc';
ncdisp(Filename)
info = ncinfo('E213_hista.nc');
year = ncread(Filename, 'year');
month = ncread(Filename,'mon');
longitude = ncread(Filename,'lon');
latitude = ncread(Filename,'lat');
sst = ncread(Filename,'sst_historical');
sss = ncread(Filename,'sss_historical');


sst = fillmissing(sst,'constant',100);
sss = fillmissing(sss,'constant',100);

sss_annual = squeeze(mean(sss,3));
sst_annual = squeeze(mean(sst,3));

for iyear = 46:55
    sstx_new = sst_annual(120:150,25:90,iyear);
    sssx_new = sss_annual(120:150,25:90,iyear);
    for ilat=1:66
        idx_sst(:,ilat,iyear)=kmeans(sstx_new(:,ilat),5);
        idx_sss(:,ilat,iyear)=kmeans(sssx_new(:,ilat),5);
    end
    figure (iyear)
    pcolor(idx_sst(:,:,iyear)');shading flat; colorbar
end



% idx_sst(find(sstx_new==100))=NaN;
% idx_sss(find(sssx_new==100))=NaN;
% figure Name 'sst_graph'
% % contourf(idx_sst(:,:,1)');colorbar 
% pcolor(idx_sst');shading flat; colorbar
% figure Name 'sss_graph'
% % contourf(idx_sss(:,:,1)');colorbar 
% pcolor(idx_sss');shading flat; colorbar


