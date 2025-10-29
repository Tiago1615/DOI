function [c, ceq] = micon(x, Q, L, P)
    % x(1) = H, x(2) = B, x(3) = D, x(4) = x
    H = x(1);
    B = x(2);
    D = x(3);
    x_val = x(4);

    % Constante: 45 grados en radianes
    theta = pi/4;

    % Cálculo de L1 y L2
    L1 = sqrt((x_val - B)^2 + H^2);
    L2 = sqrt((x_val * sin(theta) + H)^2 + (B - x_val * cos(theta))^2);

    % Fuerza F
    F = pi * P * D^2 / 4;

    % Brazo de palanca R
    if L1 == 0
        R = 0; % Evitar división por cero.
    else
        % R = |-x*sin(pi/4) + H*(B - x*cos(pi/4))| / L1
        R = abs( -x_val * (x_val * sin(theta) + H) + H * (B - x_val * cos(theta)) ) / L1;
    end

    % Restricciones de desigualdad (c <= 0)

    % c1: Q*L*cos(pi/4) - R*F <= 0
    c(1) = Q * L * cos(theta) - R * F;

    % c2: 1.2*(L2 - L1) - L1 <= 0
    c(2) = 1.2 * (L2 - L1) - L1;

    % Restricciones de igualdad
    ceq = [];
end