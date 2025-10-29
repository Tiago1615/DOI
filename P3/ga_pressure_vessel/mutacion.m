% ESTA SUBRUTINA REALIZA LA MUTACIÓN

function [pop] = mutacion(nvar, nindg, pop, minvar, maxvar, pmut, maxmut)

for i=1:1:nindg
    %Comprobamos si el individuo i muta o no
    if rand() <= pmut
        if nvar>1
            npomut = randi([1 nvar],1,1);  %determinar la variable que muta (entre 1 y nvar) 
        else 
            npomut = 1;
        end
			
		%Mutamos la variable seleccionada del individuo
        if rand() <0.5
            sign = 1.;
        else
            sign = -1.;
        end
        pop(i,npomut) = pop(i,npomut)+sign*rand()*maxmut;
        [pop(i,npomut)] = reparar(pop(i,npomut), minvar(npomut), maxvar(npomut));
    end
end
end