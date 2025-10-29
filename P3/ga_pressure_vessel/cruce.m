% ESTA SUBRUTINA REALIZA EL CRUCE ANTITETICO,
%EMPLEA UNA LEY UNIFORME PARA SELECCIONAR EL
%PUNTO/VALOR ALFA PARA EL CRUCE.
%ESTE PROCESO PARTE DE LOS INDIVIDUOS DE COPIA,
%LOS CRUZA Y DEPOSITA LOS NUEVOS INDIVIDUOS EN POP.

function [pop] = cruce(nvar, nindg, pop, copia, minvar, maxvar, pcru)

%Ponemos a cero los indicadores de individuos cruzados
for i=1:1:nindg
    copia(i,nvar+1) = 0.;
end

%Padres que no se cruzan
ndic = nindg - floor(nindg*pcru);
if mod(ndic,2) ~= 0
    ndic = ndic+1;
end

for l=1:2:ndic
    nuno = randi([1 nindg],1,1);  %determinar un individuo que no cruza (entre 1 y nindg) 
    for i=1:1:nvar
        pop(l,i) = copia(nuno,i);
    end
end
	
for l=ndic+1:2:nindg
    %Seleccionamos aleatoriamente los individuos que se cruzan:
    %nuno se cruzará con ndos
    nuno = 0;
    ndos = 0;
    [nuno] = seleccion(nuno, nvar, nindg, copia);
    [ndos] = seleccion(ndos, nvar, nindg, copia);
    while nuno == ndos
        [nuno] = seleccion(nuno, nvar, nindg, copia);
        [ndos] = seleccion(ndos, nvar, nindg, copia);
    end
    
    %Obtenemos los descendientes
    for i=1:1:nvar
        if minvar(i) ~= maxvar(i)
            alfa = -0.5+rand()*(1.5-(-0.5));
            pop(l,i) = alfa*copia(nuno,i) + (1.-alfa)*copia(ndos,i);
            [pop(l,i)] = reparar(pop(l,i), minvar(i), maxvar(i));
			pop(l+1,i) = (1.-alfa)*copia(nuno,i) + alfa*copia(ndos,i);
            [pop(l+1,i)] = reparar(pop(l+1,i), minvar(i), maxvar(i));
        end
    end
    
    %Ponemos el indicador de copias cruzadas a 1
	copia(nuno,nvar+1) = 1.;
    copia(ndos,nvar+1) = 1.;
end

end