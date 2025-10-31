function x = decode(chromosome,nvars,lc,LB,UB)
    x = LB;
    pos = 1;
    %Variables enteras: 
    for nj = 1:nvars
        x(nj) = x(nj) - 1;
        for nk = lc(nj)-1:-1:0
            x(nj) = x(nj) + double(chromosome(pos))*2^nk;
            pos = pos+1;
        end
        % Reparamos la variable
        if x(nj) > UB(nj)
            if x(nj) > UB(nj) + (2^7-UB(nj))/2
                x(nj) = UB(nj);
            else
                x(nj) = LB(nj);
            end
        end
    end
end
