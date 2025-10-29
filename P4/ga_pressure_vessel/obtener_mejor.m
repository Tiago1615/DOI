%FUNCION QUE EXTRAE LOS ÓPTIMOS LOCALES DE LA POBLACIÓN
function [nfmejor, mejor] = obtener_mejor(gen, nvar, nfmejor, pob, mejor)

if gen == 1
    nfmejor = gen;  
    mejor = pob(1,:);
else
    if pob(1,nvar+1) < mejor(nvar+1)
        nfmejor = gen;
		mejor = pob(1,:);
    end
end
    
end