function hijos = cruce(pop, pcru)
    [nindg, nbits] = size(pop);
    hijos = pop;
    
    for i = 1:2:nindg
        if rand < pcru
            punto = randi([1 nbits-1]);
            hijos(i, punto+1:end) = pop(i+1, punto+1:end);
            hijos(i+1, punto+1:end) = pop(i, punto+1:end);
        end
    end
end