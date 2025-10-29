function mutados = mutacion(pop, pmut)
    [nindg, nbits] = size(pop);
    mutados = pop;
    
    for i = 1:nindg
        for j = 1:nbits
            if rand < pmut
                mutados(i,j) = ~mutados(i,j);
            end
        end
    end
end