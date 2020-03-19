% d2_yr   [nz,ny]     y(m)
% d2_zr   [nz,ny]     depth(m) of black dots in figure
% d2_zw   [nz+1, ny]  depth(m) of gray lines in figure 
% d2_T    [nz,ny]     temperature(C)
% d2_salt [nz,ny]     salinuty(psu)
% d2_u    [nz,ny]     along-front velocity u(m/s)
% fconst  [#]         Coriolis parameter(1/s)
% g       [#]         gravitational constant(m/s2)
% rho0    [#]         background density(kg/m3) 
%-----------------------------------------------------------
% linear equation of state
%   R0 = 1027;
%   T0 = 10;
%   S0 = 32;
%   TCOEF = 1.7d-4
%   SCOEF = 7.6d-4
% DENSITY = R0 +rho0*( SCOEF*(S-S0) -TCOEF*(T-T0) );
%-----------------------------------------------------------
close all;
clear all;

load('./AnaCoastalCurrent_ini_Eady.mat');

figure; set(gcf,'Position',get(gcf,'Position').*[0.6 0.6 2.25 1.5]);

subplot(321);
  contourf(d2_yr,d2_zr,d2_T); colorbar;
  xlabel('cross-front distance (m)');
  ylabel('depth (m)');
  title('Temperature (^oC)');

subplot(323);
  contourf(d2_yr,d2_zr,d2_salt); colorbar;
  xlabel('cross-front distance (m)');
  ylabel('depth (m)');
  title('salinity (psu)');

subplot(322);
  contourf(d2_yr,d2_zr,d2_u); colorbar;
  xlabel('cross-front distance (m)');
  ylabel('depth (m)');
  title('along-front velocity u (m/s)');
  
% compute density
R0 = 1027;
T0 = 10;
S0 = 32;
TCOEF = 1.7d-4;
SCOEF = 7.6d-4;
d2_density = R0+rho0.*(SCOEF.*(d2_salt-S0)-TCOEF.*(d2_T-T0)); 
  
subplot(324);
  contourf(d2_yr,d2_zr,d2_density); colorbar;
  xlabel('cross-front distance (m)');
  ylabel('depth (m)');
  title('density');

ug = zeros(30,422);
% compute ug
k=g/(fconst*R0)
for j=2:30
    ug(j,1)=ug(j-1,1)+k*(d2_zr(32-j,1)-d2_zr(32-j-1,1))*(d2_density(32-j,2)-d2_density(32-j,1))/(d2_yr(j,2)-d2_yr(j,1));
    for i=2:421
        ug(j,i)=ug(j-1,i)+k*(d2_zr(32-j,i)-d2_zr(32-j-1,i))*(d2_density(32-j,i+1)-d2_density(32-j,i-1))/(d2_yr(j,i+1)-d2_yr(j,i-1));
    end
    ug(j,422)=ug(j-1,422)+k*(d2_zr(32-j,422)-d2_zr(32-j-1,422))*(d2_density(32-j,422)-d2_density(32-j,421))/(d2_yr(j,422)-d2_yr(j,421));
end

subplot(325);
  contourf(d2_yr,d2_zr,ug); colorbar;
  xlabel('cross-front distance (m)');
  ylabel('depth (m)');
  title('ug (m/s)');