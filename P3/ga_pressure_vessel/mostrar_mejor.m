function mostrar_mejor(x, Q, L, M_max, P)
    % Variables del problema
    H = x(1); B = x(2); D = x(3); xval = x(4);
    theta = pi/4;
    
     % L1 y L2
    L1 = sqrt((xval - B)^2 + H^2);
    L2 = sqrt((xval*sin(theta) + H)^2 + (B - xval*cos(theta))^2);

    % Datos adicionales para el cálculo de las restricciones
    F = pi*P*D^2/4;
    if L1 == 0
        R = 0;
    else
        R = abs(-xval*(xval*sin(theta)+H) + H*(B - xval*cos(theta))) / L1;
    end

    % Función objetivo (volumen de aceite)
    f = (pi/4) * D^2 * (L2 - L1);

    % c1: Q*L*cos(pi/4) - R*F <= 0
    c1 = Q * L * cos(theta) - R * F;

    % c2: 1.2*(L2 - L1) - L1 <= 0
    c2 = 1.2 * (L2 - L1) - L1;

    % Lin_c1: -Q*x4 <= M_max - Q*L  =>  -Q*x4 - (M_max - Q*L) <= 0
    c3 = -Q * xval - (M_max - Q * L);
    
    % Lin_c2: x3 - 2*x2 <= 0
    c4 = D - 2 * B;

    % Comprobar restricciones para ver si se aplica penalización,
    % obteniendo de esta forma la función de coste. De lo contrario,
    % realmente la 'f' calculada aquí, sería el volumen.
    penal = 0;
    c = [c1 c2 c3 c4];
    for j = 1:length(c)
        if c(j) > 0
            penal = penal + 1e10*c(j)^2;
        end
    end
    
    % Solución encontrada
    fprintf('\n(H, B, D, x) = (%.4f, %.4f, %.4f, %.4f)', H, B, D, xval);
    fprintf('\nFunción de coste = %.6f', f + penal);
    fprintf('\nPenalización = %.6f', penal);

    % Restricciones
    fprintf('\n\nDesglose de Restricciones');
    
    % No lineales
    fprintf('\n  [NO LINEAL] (Q*L*cos(pi/4) - R*F <= 0): %.4e', c1);
    fprintf('\n  [NO LINEAL] (1.2*(L2 - L1) - L1 <= 0): %.4e', c2);
    
    % Lineales
    fprintf('\n  [LINEAL] (Q*L - Q*x - M_max <= 0): %.4e', c3);
    fprintf('\n  [LINEAL] (D - 2*B <= 0): %.4e', c4);

    fprintf('\n--------------------------------------------\n');
end