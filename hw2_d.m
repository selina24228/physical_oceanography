load 390177_WOA13_AnnualMean.mat

PR=0;
SB=s_an(:,61,155);
TB=t_an(:,61,155);
PB=sw_pres(depth,-29);
ptmp=sw_ptmp(SB,TB,PB,PR);

%plotting
figure;
xlabel('Pressure,db');
ylabel('depth,m');
scatter(TB,depth);
hold on;
scatter(ptmp,depth,'*');
disp(TB-ptmp);
hold off;

%part1-e
dens=sw_dens(SB,TB,PB)-1000;
dens_t=sw_dens(SB,TB,PR)-1000;
dens_theta=sw_dens(SB,ptmp,PR)-1000;
figure;
scatter(dens,depth);
hold on;
scatter(dens_t,depth,'*');
scatter(dens_theta,depth,'o');