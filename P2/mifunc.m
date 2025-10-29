function f = mifunc(x)
    % x(1) = H, x(2) = B, x(3) = D, x(4) = x
    H = x(1);
    B = x(2);
    D = x(3);
    x_val = x(4);

    % Constante: 45 grados en radianes
    theta = pi/4;

    % Cálculo de L1
    L1 = sqrt((x_val - B)^2 + H^2);

    % Cálculo de L2
    L2 = sqrt((x_val * sin(theta) + H)^2 + (B - x_val * cos(theta))^2);

    % Función objetivo: volumen de aceite
    f = (pi/4) * D^2 * (L2 - L1);
end