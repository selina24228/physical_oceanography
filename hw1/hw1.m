close all;
clear all;

url = 'https://data.nodc.noaa.gov/thredds/dodsC/nodc/archive/data/0114815/public/temperature/netcdf/decav/1.00/woa13_decav_t00_01.nc';
ncdisp(url);
lat = ncread(url,'lat');
lon = ncread(url,'lon');
depth = ncread(url,'depth');
t_an = ncread(url,'t_an');

url_s ='https://data.nodc.noaa.gov/thredds/dodsC/nodc/archive/data/0114815/public/salinity/netcdf/decav/1.00/woa13_decav_s00_01.nc'
ncdisp(url_s);
s_an = ncread(url_s,'s_an');

figure(1);
subplot(2,1,1);
    contourf(lon,lat,transpose(t_an(:,:,1)),20);colorbar;
    xlabel("longtitude");
    ylabel("lantitude");
    title("Temperature at sea surface")
subplot(2,1,2);
    contourf(lon,lat,transpose(s_an(:,:,1)),20);colorbar;
    xlabel("longtitude");
    ylabel("lantitude");
    title("Salinity at sea surface")

depth = -1*depth;
figure(2);
subplot(2,1,1);
    contourf(lat,depth,transpose(squeeze(t_an(155,:,:))),20); colorbar;
    xlabel("lantitude");
    ylabel("depth");
    title("Temperature at 24.5W")
subplot(2,1,2);
    contourf(lat,depth,transpose(squeeze(s_an(155,:,:))),20); colorbar;
    xlabel("lantitude");
    ylabel("depth");
    title("Salinity at 24.5W")

%tropics : 10.5S, 24.5W, red
%subtropics : 30.5S, 24.5W, green
%subpolar : 50.5S, 24.5W, blue
%polar : 70.5S, 24.5W, black

figure(3);
subplot(1,2,1);
    plot(squeeze(t_an(155,79,:)),depth,'r');
    hold on;
    plot(squeeze(t_an(155,59,:)),depth,'g');
    plot(squeeze(t_an(155,39,:)),depth,'b');
    plot(squeeze(t_an(155,19,:)),depth,'k');
    hold off;
    xlabel("Temperature");
    ylabel("depth");

subplot(1,2,2);
    plot(squeeze(s_an(155,79,:)),depth,'r');
    hold on;
    plot(squeeze(s_an(155,59,:)),depth,'g');
    plot(squeeze(s_an(155,39,:)),depth,'b');
    plot(squeeze(s_an(155,19,:)),depth,'k');
    hold off;
    xlabel("Salinity");
    ylabel("depth");
    


dT = [t_an(155,79,102)-t_an(155,79,1), t_an(155,59,95)-t_an(155,59,1), t_an(155,39,79)-t_an(155,39,1), t_an(155,19,89)-t_an(155,19,1)]
ds = [s_an(155,79,102)-s_an(155,79,1), s_an(155,59,95)-s_an(155,59,1), s_an(155,39,79)-s_an(155,39,1), s_an(155,19,89)-s_an(155,19,1)]
alpha = 2*10^(-4)
beta = 7.6*10^(-4)
R0 = 1027
dR = R0 * (-alpha * dT + beta * ds)