function hijos = cruce(pop, pcru)
    % Número de individuos (nindg) y el número de bits por cromosoma (nbits)
    [nindg, nbits] = size(pop);

    % Matriz de hijos (copia de la población original)
    hijos = pop;
    
    % Recorrer la población de dos en dos (pares de padres)
    for i = 1:2:nindg
        % Comprueba si este par se cruza según la probabilidad pcru
        if rand < pcru
            % Seleccionar un punto de cruce aleatorio entre 1 y nbits-1
            punto = randi([1 nbits-1]);

            % Intercambia los bits a la derecha del punto de cruce
            % entre los dos padres para generar los dos hijos
            hijos(i, punto+1:end) = pop(i+1, punto+1:end);
            hijos(i+1, punto+1:end) = pop(i, punto+1:end);
        end
    end
end
