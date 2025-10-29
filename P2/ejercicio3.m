clc
clear
close all

% ---------------------
% Datos del problema
% ---------------------

Q = 10000;
L = 240;
M_max = 1.8e6;
P = 1500;

% ---------------------
% Variables y límites
% ---------------------

nvars = 4;
LB = [0.05, 0.05, 0.05, 0.05];
UB = [Inf, Inf, Inf, 120];

% ----------------------
% Restricciones lineales
% ----------------------

A = [0, 0, 0, -Q
     0, -2, 1, 0];

B = [M_max - Q * L; 0];

% ---------------------
% Punto inicial
% ---------------------

x0 = [1, 1, 1, 1];

% ---------------------
% Uso de fmincon
% ---------------------

options = optimoptions('fmincon','Display','iter', ...
    'PlotFcns','optimplotfval');

[x,fval,exitflag,output] = fmincon(@mifunc,x0,A,B,[],[],LB,UB,@(x)micon(x, Q, L, P),options);

mostrar_solucion(x, output.funcCount, exitflag, fval, Q, L, P, M_max);
