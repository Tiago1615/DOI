%FUNCION QUE EXTRAE LOS �PTIMOS LOCALES DE LA POBLACI�N
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