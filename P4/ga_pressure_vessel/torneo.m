%FUNCION QUE REALIZA LA SELECCION POR TORNEO DE 2, 3 Ó 5
%INDIVIDUOS. NUINTOR ES EL NUMERO DE INDIVIDUOS QUE INTERVIENEN
%EN EL TORNEO. SI NUINTOR=2 O NUINTOR=3, SE ELIGE EL MEJOR, SI
%NUINTOR=5 SE ELIGEN LOS DOS MEJORES.
%LOS INDIVIDUOS SELECCIONADOS SE ALMACENAN EN COPIA

function [copia] = torneo(nuintor, lctotal, nindg, pop)

nintentos = 10;
nn = zeros(1,nuintor);
copia = zeros(nindg,lctotal);

%Comenzamos con el torneo
if nuintor == 5
    nmax = 2;
else
    nmax = 1;
end

for i=1:nmax:nindg
    %Elegimos a los candidatos
    ndic = 1;
    caso = 0;
    for k=1:1:nuintor
        nn(k) = randi([1 nindg],1,1);  %determinar el individuo que muta (entre 1 y nindg)
    end
    for k=1:1:nuintor
        for j=k+1:1:nuintor
            if nn(k) == nn(j)
                caso = 1;
                break
            end
        end
        if caso==1
            break
        end
    end
        
    while ndic <= nintentos && caso == 1
        ndic = ndic + 1;
        caso = 0;
        for k=1:1:nuintor
            nn(k) = randi([1 nindg],1,1);  %determinar el individuo que muta (entre 1 y nindg)
        end
        
        for k=1:1:nuintor
            for j=k+1:1:nuintor
                if nn(k) == nn(j)
                    caso = 1;
                    break
                end
            end
            if caso==1
                break
            end
        end
    end
    
    %Ordenamos los índices de los competidores de menor a mayor
    for k=1:1:nuintor
        for j=(k+1):1:nuintor
            if nn(j) < nn(k)
                nmin = nn(j);
                nn(j) = nn(k);
                nn(k) = nmin;
            end
        end
    end
    
	%Nos quedamos con el mejor individuo entre los candidatos.
    %Es decir, el de menor índice
    ndic = nn(1);
    if ndic == 0
        ndic = 1;
    end
    copia(i,:) = pop(ndic,:);
        
    if nuintor == 5
        %Nos quedmos también con elsegundo mejor individuo entre los candidatos.
        ndic = nn(2);
        if ndic == 0
            ndic = 1;
        end
        copia(i+1,:) = pop(ndic,:);
    end
end