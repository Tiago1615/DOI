clc
clear
close all

figure(1)
[x_grid, y_grid] = meshgrid(linspace(-10,10,500));
z_grid = myfun(x_grid, y_grid);
surf(x_grid, y_grid, z_grid);
shading interp;
grid on
xlabel('x'), ylabel('y'), zlabel('z');
title('Mesa de Soporte');

figure(2)
v = [-20, -18, -15, -10, -5, -1];
contour(x_grid, y_grid, z_grid, v, LineWidth=3);
grid on
xlabel('x'), ylabel('y'), title('Contornos de la mesa')
hold on

disp ('-----------------------------')
disp ('Ejercicio 2:')
disp ('-----------------------------')

function [f] = myfun(x1, x2)
    f = -abs(sin(x1) .* cos(x2) .* exp(abs(1 - sqrt(x1.^2 + x2.^2)/pi)));
end

function [] = GetMinByPoint(x0)

    options = optimoptions('fminunc','Display','iter','TolFun',1.e-12, ...
	    'TolX',1.e-12,'PlotFcns','optimplotfval');
    
    [xopt,fval,exitflag,output] = fminunc(@(x) myfun(x(1), x(2)),x0,options);
    
    fprintf('\n');
    disp(['Punto: ', '(', num2str(x0(1)), ', ', num2str(x0(2)), ')']);
    fprintf('\nLa función alcanza el mínimo en (x,y) = (%f,%f)',xopt(1),xopt(2));
    fprintf('\nEl valor de la función en dicho punto es f = %f',fval);
    fprintf('\nEl valor de la variable EXITFLAG es %d\n',exitflag);
    
    fprintf('\nAlgoritmo utilizado: %s',output.algorithm);
    fprintf('\nNúmero de iteraciones del algoritmo: %d',output.iterations);
    fprintf('\nNúmero de evaluaciones de la función: %d\n\n',output.funcCount);
    
    figure(1)
    hold on
    plot3(xopt(1),xopt(2),fval,'ro','LineWidth',2,...
        'MarkerSize',5,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r')
    hold off
    
    figure(2)
    hold on
    plot(xopt(1),xopt(2),'ro','LineWidth',2,...
        'MarkerSize',5,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r')
    hold off

end

% Para ver los resultados, hay que ir descomentando y comentando las
% llamadas a GetMinByPoint()

% Apartado a)

GetMinByPoint([0,0]);
%GetMinByPoint([5,5]);
%GetMinByPoint([7,8]);    % <---- Punto óptimo

% Apartado b)

% Punto óptimo, conocido del apartado anterior
%GetMinByPoint([7,8]);

% Resto de puntos óptimos, sacados por simetría
%GetMinByPoint([-7,-8]);
%GetMinByPoint([-7,8]);
%GetMinByPoint([7,-8]);
