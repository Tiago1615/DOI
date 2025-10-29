function [copia] = torneo(nuintor, nindg, pop)
    % Selección por torneo binaria
    % nuintor : número de individuos por torneo (2,3,5)
    % nindg   : número total de individuos
    % pop     : matriz binaria (nindg x lctotal)
    
    % Inicialización
    [nindg, lctotal] = size(pop);
    copia = false(nindg, lctotal);
    
    % Número de ganadores por torneo
    if nuintor == 5
        nmax = 2;
    else
        nmax = 1;
    end
    
    for i = 1:nmax:nindg
        % Selecciona 'nuintor' competidores distintos
        indices = randperm(nindg, nuintor);
        
        % Gana el de menor índice (equivale a mejor fitness en orden)
        ganador1 = min(indices);
        copia(i, :) = pop(ganador1, :);
        
        % Si nuintor = 5, toma también el segundo mejor
        if nuintor == 5 && (i+1) <= nindg
            indices = sort(indices);
            ganador2 = indices(2);
            copia(i+1, :) = pop(ganador2, :);
        end
    end
end