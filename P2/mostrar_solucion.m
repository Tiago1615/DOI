function mostrar_solucion(x, funccount, exitflag, fval, Q, L, P, M_max)
    % x(1) = H, x(2) = B, x(3) = D, x(4) = x
    
    % Verificar las restricciones No Lineales
    [c, ~] = micon(x, Q, L, P);
    max_violacion_c = max(c);
    tolerancia = 1e-6;

    % Verificar las restricciones Lineales

    % Lin_c1: -Q*x4 <= M_max - Q*L  =>  -Q*x4 - (M_max - Q*L) <= 0
    lin_c1_valor = -Q * x(4) - (M_max - Q * L); 
    
    % Lin_c2: x3 - 2*x2 <= 0
    lin_c2_valor = x(3) - 2 * x(2);             
    
    fprintf('\n------------------------------------------------');
    fprintf('\nRESULTADOS DE LA OPTIMIZACIÓN (fmincon)');
    fprintf('\n------------------------------------------------');
    
    % Solución
    H = round(x(1), 4);
    B = round(x(2), 4);
    D = round(x(3), 4);
    x_val = round(x(4), 4);

    % Restricciones de Acotación
    fprintf('\nLímites de Acotación: H, B, D >= 0.05, 0.05 <= x <= 120.');
    
    fprintf('\n\nSolución hallada (H, B, D, x): (%.4f, %.4f, %.4f, %.4f)', H, B, D, x_val);
    fprintf('\nValor de la función objetivo (Volumen de aceite): %.4f', fval);
    fprintf('\nNúmero de evaluaciones de la función objetivo: %d', funccount);

    % Factibilidad
    fprintf('\n\nFactibilidad:');
    if exitflag == 1
        fprintf('\nEXITFLAG = 1: El algoritmo CONVERGIÓ a una solución localmente óptima y factible.');
    elseif max_violacion_c > tolerancia
        fprintf('\nEXITFLAG = %d: La solución no es estrictamente factible. Máx. Violación NO LINEAL: %.4e', exitflag, max_violacion_c);
        fprintf('\nSe recomienda modificar la condición inicial (x0) o las opciones de fmincon.');
    else
        fprintf('\nEXITFLAG = %d: Solución Factible (dentro de la tolerancia), pero no óptima.', exitflag);
    end

    % Restricciones
    fprintf('\n\nDesglose de Restricciones');
    
    % No lineales
    fprintf('\n  [NO LINEAL] c1 (Q*L*cos(pi/4) - R*F <= 0): %.4e', c(1));
    fprintf('\n  [NO LINEAL] c2 (1.2*(L2 - L1) - L1 <= 0): %.4e', c(2));
    
    % Lineales
    fprintf('\n  [LINEAL] Lin_c1 (Q*L - Q*x - M_max <= 0): %.4e', lin_c1_valor);
    fprintf('\n  [LINEAL] Lin_c2 (D - 2*B <= 0): %.4e', lin_c2_valor);
    
    fprintf('\n------------------------------------------------\n');

end