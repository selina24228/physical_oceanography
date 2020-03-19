load 390177_WOA13_AnnualMean.mat

T1=0:30;
S1=0:40;
T=repmat(T1,[41 1]);
S=repmat(S1',[1 31]);
p=1000;
dens=sw_dens(S,T,p)-1000;
%s_an_1D=s_an(:);
%t_an_1D=t_an(:);
%%%% plotting
figure;
[c,h]=contour(S,T,dens,[0:2:40],'k');
clabel(c,h,'LabelSpacing',200,'FontSize',[12],'Rotation',0);
%making the figure nice:
axis([33 37 0 30]);
xlabel('Salinity,ppt');
ylabel('Temperature,^oC');

%plot sea water(part1-b)
hold on;
x=[33.8 33.8 34.3 34.3];
y=[2.5 4.0 4.0 2.5];
fill(x,y,'b');
x=[34.92 34.92 34.97 34.97];
y=[2.4 3.0 3.0 2.4];
fill(x,y,'b');
x=[34.6 34.6 34.7 34.7];
y=[0 0.5 0.5 0];
fill(x,y,'b');
clear x y;

%part1-c
SA=s_an(:,125,170);
TA=t_an(:,125,170);
SB=s_an(:,61,155);
TB=t_an(:,61,155);
scatter(SA,TA,'*');
scatter(SB,TB,'*');