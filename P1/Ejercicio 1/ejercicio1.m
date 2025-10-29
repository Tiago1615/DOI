clc
clear
close all

disp ('-----------')
disp ('Ejercicio 1: ')
disp ('-----------')

function [] = GetMinByInterval(a, b)
    figure;
    
    x = (0:0.01:4);
    y = -exp(-x) .* sin(2 * pi * x);
    plot(x, y, '-r', 'LineWidth', 2)    
    grid on;
    xlabel('x');
    ylabel('f(x)');
    title(['Función y Mínimo en el intervalo [' num2str(a) ',' num2str(b) ']']);
    hold on;
    
    options = optimset('Display','iter');

    [x, fval, exitflag, output] = fminbnd(@(x) -exp(-x) .* sin(2 * pi * x), a, b, options);
    
    disp(['Intervalo: ', num2str(a), ' < x < ', num2str(b)]);
    fprintf('\nLa función alcanza el mínimo en x = %f', x);
    fprintf('\nEl valor de la función en dicho punto es f = %f', fval);
    fprintf('\nEl valor de la variable EXITFLAG es %d\n', exitflag);
    fprintf('\nAlgoritmo utilizado: %s', output.algorithm);
    fprintf('\nNúmero de iteraciones del algoritmo: %d', output.iterations);
    fprintf('\nNúmero de evaluaciones de la función: %d', output.funcCount);
    fprintf('\n%s\n', output.message);
    disp ('----------------------------------------------------------------------------------------')
    
    plot(x, fval, 'bo', 'LineWidth', 2,...
        'MarkerSize', 5,...
        'MarkerEdgeColor','y',...
        'MarkerFaceColor','y');
    
    hold off;
end

GetMinByInterval(0,4)
GetMinByInterval(0,2)
GetMinByInterval(0,1)

hold off
