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
    pos = 0;
    
    for i = 1:nvars
        bits = chrom(pos+1 : pos+lc(i));
        pos = pos + lc(i);
    
        val = polyval(bits, 2);
        x(i) = round(LB(i) + val * (UB(i) - LB(i)) / (2^lc(i) - 1));
    end
end
