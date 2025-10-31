function mostrar_mejor(x)
    % Muestra la mejor solución encontrada
    f = ((1/6.931) - (x(1)*x(2))/(x(3)*x(4)))^2;
    
    fprintf('\nBest solution found: (x1, x2, x3, x4) = (%.4f, %.4f, %.4f, %.4f)', ...
        x(1), x(2), x(3), x(4));
    fprintf('\nObjective function value f(x) = %.12e\n\n', f);
end
