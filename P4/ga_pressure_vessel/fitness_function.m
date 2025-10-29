function [fval]=fitness_function(nvars, nindg, pop, lc, LB, UB)

    fval = zeros(nindg,1);
    
    for ni = 1:nindg
        % Decodificamos el cromosoma binario a valores reales
        x = decode(pop(ni,:), nvars, lc, LB, UB);
    
        % Ajuste de variables enteras (Ts, Th)
        %x(1) = x(1) * 0.0625;
        %x(2) = x(2) * 0.0625;
    
        % --- Función objetivo ---
        fval(ni) = ( (1/6.931) - (x(1)*x(2)) / (x(3)*x(4)) )^2;
    
        % Restricciones
        %volumen = pi*x(3)^2*x(4) + (4/3)*pi*x(3)^3;
    
        %if volumen - 750*12^3 < 0
        %    fval(ni,1) = fval(ni,1) + 1e20*(volumen - 750*12^3)^2;
        %end
        %if x(1) - 0.0193*x(3) < 0
        %    fval(ni,1) = fval(ni,1) + 1e20*(x(1) - 0.0193*x(3))^2;
        %end
        %if x(2) - 0.00954*x(3) < 0
        %    fval(ni,1) = fval(ni,1) + 1e20*(x(2) - 0.00954*x(3))^2;
        %end
    end
end