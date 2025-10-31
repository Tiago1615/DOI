function mutados = mutacion(pop, pmut)
    % Número de individuos y el número de bits por cromosoma
    [nindg, nbits] = size(pop);

    % Matriz de salida inicializada como copia de la población original
    mutados = pop;
    
    % Recorre todos los individuos de la población
    for i = 1:nindg

        % Recorre cada bit del cromosoma actual
        for j = 1:nbits
            % Con probabilidad pmut, se decide mutar este bit
            if rand < pmut
                % Se invierte el bit, si era 1 pasa a 0, si era 0 pasa a 1
                mutados(i,j) = ~mutados(i,j);
            end
        end
    end
end
