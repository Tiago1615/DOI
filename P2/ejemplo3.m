clc   % Clear Command Window.
clear % Clear variables and functions from memory.
close all

% FMINCON attempts to solve problems of the form:
%      min F(X)  subject to:  A*X  <= B, Aeq*X  = Beq (linear constraints)
%       X                     C(X) <= 0, Ceq(X) = 0   (nonlinear constraints)
%                               LB <= X <= UB        (bounds)
%
% [X,FVAL,EXITFLAG] = FMINCON(F,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS)

nvars = 4;
LB = [0.0625 0.0625 10 10];
UB = [99*0.0625 99*0.0625 200 240];

x0 = ones(1,nvars);

A = [-1 0 0.0193 0; 0 -1 0.00954 0];
B = zeros(1,2);

options = optimoptions('fmincon','Display','iter', ...
    'PlotFcns','optimplotfval');

[x,fval,exitflag,output] = fmincon(@mifunc,x0,A,B,[],[],LB,UB,@micon,options);

mostrar_solucion(x,output.funcCount);

% Possible values of EXITFLAG and the corresponding exit conditions:  
%     All algorithms:
%       1  First order optimality conditions satisfied.
%       0  Too many function evaluations or iterations.
%      -1  Stopped by output/plot function.
%      -2  No feasible point found.
%     Trust-region-reflective and interior-point:
%       2  Change in X too small.
%     Trust-region-reflective:
%       3  Change in objective function too small.
%     Active-set only:
%       4  Computed search direction too small.
%       5  Predicted change in objective function too small.
%     Interior-point:
%      -3  Problem seems unbounded.