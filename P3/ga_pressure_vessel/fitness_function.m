%FUNCION CALCULA LOS VALORES DE LAS FUNCIONES OBJETIVO
function [pop]=fitness_function(nvars, nindg, pop, Q, L, P, M_max)

    theta = pi/4;
    for i = 1:nindg
        % Variables del problema
        H = pop(i,1); B = pop(i,2); D = pop(i,3); x = pop(i,4);
    
        % L1 y L2
        L1 = sqrt((x - B)^2 + H^2);
        L2 = sqrt((x*sin(theta) + H)^2 + (B - x*cos(theta))^2);
    
        % Función objetivo (volumen de aceite)
        f = (pi/4)*D^2*(L2 - L1);
    
        % Restricciones
        F = pi*P*D^2/4;
        if L1 == 0
            R = 0;
        else
            R = abs(-x*(x*sin(theta)+H) + H*(B - x*cos(theta))) / L1;
        end
    
        c1 = Q*L*cos(theta) - R*F;
        c2 = Q*(L - x) - M_max;
        c3 = 1.2*(L2 - L1) - L1;
        c4 = D/2 - B;
    
        % Cálculo de la penalización por incumplir las restricciones
        penal = 0;
        c = [c1 c2 c3 c4];
        for j = 1:length(c)
            if c(j) > 0
                penal = penal + 1e10*c(j)^2;
            end
        end
    
        pop(i,nvars+1) = f + penal;
    end
end