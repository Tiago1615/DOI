function [candidato, flag] = seleccion(nindg, flag)

nintentos = 10;

caso = 1;
while caso == 1
    %Seleccionamos un individuo para el cruce
    ndic=0;
    while caso == 1
        candidato = randi([1 nindg],1,1);  %determinar el candidato (entre 1 y nindg)
        if flag(candidato) == 1
            ndic = ndic+1;
            if ndic > nintentos
                caso = 0;
            end
        else
            caso = 0;
        end
    end
    
end