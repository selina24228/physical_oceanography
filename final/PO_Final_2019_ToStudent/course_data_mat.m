% grd.y_rho   [ny]           y(m), cross-channel
% grd.f       [ny]           Coriolis parameter(1/s)
% var.time    [nt]           model time (s)
% var.zw      [nt,nz+1,ny]   depth(m) of gray lines in figure 
% var.zr      [nt,nz,  ny]   depth(m) of black dots in figure
% var.temp    [nt,nz,  ny]   temperature(C)
% var.salt    [nt,nz,  ny]   salinuty(psu)
% var.u       [nt,nz,  ny]   along-channel velocity u(m/s)
% var.v       [nt,nz,  ny]   cross-channel velocity v(m/s)
% var.w       [nt,nz,  ny]   vertical velocity w(m/s)
% taux        [nt]           surface wind stress in x direction (N/m2)
% tauy        [nt]           surface wind stress in y direction (N/m2)
% AKv         [#]            eddy viscosity (m2/s)
%-----------------------------------------------------------
% linear equation of state
% R0 = 1027;
% T0 = 14;
% S0 = 35;
% TCOEF = 1.7d-4
% SCOEF = 7.6d-4
% DENSITY = R0 +rho0*( SCOEF*(S-S0) -TCOEF*(T-T0) );
%-----------------------------------------------------------
close all;
clear all;

load('./upwelling.mat');

[nt,nz,ny]=size(var.zr);

ntht = nt;    % plot the last time step as an example

d2_yr    = repmat( reshape(grd.y_rho,[1 ny]), [nz 1] );  % y
d2_zr    = squeeze( var.zr(  ntht,:,:) );                % z
d2_T     = squeeze( var.temp(ntht,:,:) );
d2_salt  = squeeze( var.salt(ntht,:,:) );
d2_u     = squeeze( var.u(   ntht,:,:) );
d2_v     = squeeze( var.v(   ntht,:,:) );

R0 = 1027;
T0 = 14;
S0 = 35;
TCOEF = 1.7d-4
SCOEF = 7.6d-4
d2_d     = R0 +R0*( SCOEF.*(d2_salt-S0) -TCOEF.*(d2_T-T0));

figure(1); set(gcf,'Position',get(gcf,'Position').*[0.6 0.6 2.25 1.5]);

subplot(231);
  contourf(d2_yr,d2_zr,d2_T); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('Temperature (^oC)');

subplot(234);
  contourf(d2_yr,d2_zr,d2_salt); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('salinity (psu)');

subplot(232);
  contourf(d2_yr,d2_zr,d2_u); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('along-channel velocity u (m/s)');

subplot(235);
  contourf(d2_yr,d2_zr,d2_v); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('cross-channel velocity v (m/s)');
  
subplot(233);
  contourf(d2_yr,d2_zr,d2_d); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('density (kg/m^3)');

g=9.8  
u=zeros(16,82);
u(1,:)=d2_v(1,:);
u(:,1)=d2_v(:,1);
for i =2:82
    for j = 2:16
        u(j,i) = u(j-1,i)+(var.zw(ntht,j+1,i)-var.zw(ntht,j,i))*(g/grd.f(i)/R0)*(d2_d(j,i)-d2_d(j,i-1))/(grd.y_rho(i)-grd.y_rho(i-1));
    end
end

subplot(236);
  contourf(d2_yr,d2_zr,u); colorbar;
  xlabel('cross-channel distance (m)');
  ylabel('depth (m)');
  title('u (m/s)');
  
figure(2); set(gcf,'Position',get(gcf,'Position').*[0.6 0.6 2.25 1.5]);
zoom on;
rotate3d on;
z_0=zeros(size(d2_zr(:,41)))
quiver3(z_0,d2_yr(:,41),d2_zr(:,41),d2_u(:,41)-u(:,41),d2_v(:,41),z_0,0.5);

