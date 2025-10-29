function [copia] = torneo(nuintor, nindg, pop)
    % Selecci�n por torneo binaria
    % nuintor : n�mero de individuos por torneo (2,3,5)
    % nindg   : n�mero total de individuos
    % pop     : matriz binaria (nindg x lctotal)
    
    % Inicializaci�n
    [nindg, lctotal] = size(pop);
    copia = false(nindg, lctotal);
    
    % N�mero de ganadores por torneo
    if nuintor == 5
        nmax = 2;
    else
        nmax = 1;
    end
    
    for i = 1:nmax:nindg
        % Selecciona 'nuintor' competidores distintos
        indices = randperm(nindg, nuintor);
        
        % Gana el de menor �ndice (equivale a mejor fitness en orden)
        ganador1 = min(indices);
        copia(i, :) = pop(ganador1, :);
        
        % Si nuintor = 5, toma tambi�n el segundo mejor
        if nuintor == 5 && (i+1) <= nindg
            indices = sort(indices);
            ganador2 = indices(2);
            copia(i+1, :) = pop(ganador2, :);
        end
    end
end