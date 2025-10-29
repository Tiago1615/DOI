%FUNCION GENERA POBLACION INICIAL POR LEY UNIFORME
function [pop]=generar_poblacion_ley_uniforme(nvar, nindg, minvar, maxvar)

pop = zeros(nindg,nvar); %matriz población con nº filas = nindg  
                            %nº de columnas = nvar.
for ni=1:1:nindg
    for nj=1:1:nvar
        pop(ni,nj) = minvar(1,nj)+rand()*(maxvar(1,nj)-minvar(1,nj));
    end
end
end