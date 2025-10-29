function mostrar_mejor(x)
    % Muestra los resultados del mejor individuo (ya decodificado)
    
    % Ajustar las dos primeras variables a incrementos de 0.0625
    x(1) = x(1) * 0.0625;
    x(2) = x(2) * 0.0625;
    
    coste = 0.6224*x(1)*x(3)*x(4) + ...
            1.7781*x(2)*x(3)^2 + ...
            3.1661*x(1)^2*x(4) + ...
            19.86*x(1)^2*x(3);
    
    volumen = pi*x(3)^2*x(4) + (4/3)*pi*x(3)^3;
    
    fprintf('\nThe best solution was found in (Ts Th R L) = (%.4f, %.4f, %.4f, %.4f)',...
        x(1), x(2), x(3), x(4));
    fprintf('\nThe total cost of the vessel is %f', coste);
    fprintf('\nThe volume of the vessel is: %f (>= 1,296,000)', volumen);
    fprintf('\nTs/R is: %f (>= 0.0193)', x(1)/x(3));
    fprintf('\nTh/R is: %f (>= 0.00954)\n\n', x(2)/x(3));
end