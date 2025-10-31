% function x = decode(chrom, nvars, lc, LB, UB)
%     % DECODIFICA un cromosoma binario a sus valores reales o enteros
%     % chrom : vector binario (1xN)
%     % nvars : número de variables
%     % lc     : vector con longitudes de cada variable
%     % LB, UB : límites inferiores y superiores
% 
%     x = zeros(1, nvars);
%     pos = 0;
% 
%     for i = 1:nvars
%         % Extraer los bits correspondientes a la variable i
%         bits = chrom(pos+1 : pos+lc(i));
%         pos = pos + lc(i);
% 
%         % Convertir binario -> decimal usando polyval
%         % Ejemplo: bits = [1 0 1] → val = 1*2^2 + 0*2^1 + 1*2^0 = 5
%         val = polyval(bits, 2);
% 
%         % Escalar al rango [LB, UB]
%         if i <= 2
%             % Variables enteras
%             x(i) = round(LB(i) + val * (UB(i) - LB(i)) / (2^lc(i) - 1));
%         else
%             % Variables reales
%             x(i) = LB(i) + val * (UB(i) - LB(i)) / (2^lc(i) - 1);
%         end
%     end
% end

function x = decode(chrom, nvars, lc, LB, UB)
    % Decodifica un cromosoma binario a valores enteros dentro de [LB, UB]
    
    x = zeros(1, nvars);

    % Variable auxiliar para controlar la posición dentro del cromosoma
    pos = 0;
    
    for i = 1:nvars
        % Extraer los bits
        bits = chrom(pos+1 : pos+lc(i)); % chrom(pos+1 : pos+lc(i)) selecciona la subcadena binaria

        % Actualiza la posición de lectura para la siguiente variable
        pos = pos + lc(i);
    
        % Convierte la secuencia binaria en un valor entero
        % polyval(bits,2) evalúa el polinomio con base 2
        val = polyval(bits, 2);

        % Escalar el valor decimal al rango real [LB(i), UB(i)] y luego se 
        % redondea para obtener un valor entero válido
        x(i) = round(LB(i) + val * (UB(i) - LB(i)) / (2^lc(i) - 1));
    end
end
