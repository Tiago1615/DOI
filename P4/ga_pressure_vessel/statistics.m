function [fvalmin,nmin] = statistics(ensayos,fbest,fworst,fmean,fstd,fmedian)

fprintf("\nEstudio estadístico:");
fprintf("\n--------------------");
fprintf('\nEl número de ensayos realizados es %d',ensayos);
if fbest(1) < 1.e-3
    fprintf('\nEl valor medio de los mejores encontrados es %.3e',mean(fbest));
    fprintf('\nLa desviación típica de los mejores encontrados es %.3e',std(fbest));
    fprintf('\nLos cinco números de Tukey son: %.4e %.4e %.4e %.4e %.4e\n',quantile(fbest,(0:0.25:1)));
else
    fprintf('\nEl valor medio de los mejores encontrados es %.3f',mean(fbest));
    fprintf('\nLa desviación típica de los mejores encontrados es %.3f',std(fbest));
    fprintf('\nLos cinco números de Tukey son: %.4f %.4f %.4f %.4f %.4f\n',quantile(fbest,(0:0.25:1)));
end

[fvalmin,nmin] = min(fbest(1:ensayos));

%Guardamos los resultados obtenidos en fichero
fid = fopen('statistics.txt', 'w');
fprintf(fid,'ensayo mejor peor media sdt mediana');
for nensayo=1:ensayos
    fprintf(fid,'\n%d %e %e %e %e %e',nensayo,fbest(nensayo),fworst(nensayo),...
        fmean(nensayo),fstd(nensayo),fmedian(nensayo));
end
fclose(fid);


%Representación gráfica de los resultados
figure (1)
subplot(3,1,1)
plot(fbest,'--gs','LineWidth',2,'MarkerSize',6,...
    'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
xlabel('Trial')
ylabel('Fitness Function')
subplot(3,1,2)
boxplot(fbest,'orientation','horizontal');
xlabel('Fitness Function')
title('Boxplot');
subplot(3,1,3)
histogram(fbest);
xlabel('Fitness Function')
title('Histogram');


figure (2)
plot(fbest,'ro','MarkerFaceColor',[1,0,0]);
xlim([0 ensayos+1]);grid;
hold on
plot(fworst,'ks','MarkerSize',8);
plot(fmedian,'b:.');
legend('best','worst','median','Location','NorthEast')
hold off

end