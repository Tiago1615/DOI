function [fval]=fitness_function(nvars, nindg, pop, lc, LB, UB)

    fval = zeros(nindg,1);
    
    for ni = 1:nindg
        % Decodificamos el cromosoma binario a valores enteros
        x = decode(pop(ni,:), nvars, lc, LB, UB);
    
        % Función objetivo
        fval(ni) = ( (1/6.931) - (x(1)*x(2)) / (x(3)*x(4)) )^2;
    end
end