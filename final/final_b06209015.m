test=xlsread('FinalExam_Data_training.xlsx');
predict=xlsread('FinalExam_Data_testing.xlsx');
wtio=test(:,10);
tpe=test(:,2);
p_wtio=predict(:,10);
p_tpe=predict(:,2);
%a2
%scatter plot
plot(wtio,tpe,'.')
title('Correlation between WTIO and Taipei temp')
xlabel('WTIO SST index')
ylabel('temp. Taipei')
saveas(gcf,'scatterplot.png','png');
close
%boxplot
figure()
boxplot(tpe)
title('temp. Taipei')
saveas(gcf,'tpe_boxplot.png','png');
close
figure()
boxplot(wtio)
title('WTIO')
saveas(gcf,'wtio_boxplot.png','png');
close
%density plot
figure()
histogram(tpe,25)
title('Temp. Taipei')
xlabel('Temp. Taipei')
ylabel('density')
saveas(gcf,'tpe_hist.png','png');
close
figure()
histogram(wtio,25)
title('WTIO')
xlabel('sst index')
ylabel('density')
saveas(gcf,'wtio_hist.png','png');
close
%qq plot
figure()
qqplot(tpe)
title('Temp. Taipei')
xlabel('Theoretical Quantiles')
ylabel('Sample Quantiles')
saveas(gcf,'tpe_qq.png','png');
close
figure()
qqplot(wtio)
title('WTIO')
xlabel('Theoretical Quantiles')
ylabel('Sample Quantiles')
saveas(gcf,'wtio_qq.png','png');
close
%a3&a4
R=fitlm(wtio,tpe)
predict_tpe=0.058121+1.13198*p_wtio;
%a5
err=mean((predict_tpe - p_tpe).^2);
mse=sqrt(err);
r_mod=1-(sum((predict_tpe - p_tpe).^2)/(sum((mean(p_tpe) - p_tpe).^2)))

