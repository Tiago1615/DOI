%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ALGORITMO GENETICO: Se quiere construir una vasija de presión cilíndrica 
% tapada por ambos lados con cabezas hemisféricas. El objetivo es minimizar 
% el costo total, incluyendo el costo del material, forma y soldadura. El 
% tanque de almacenamiento de aire ha de soportar una presión de trabajo 
% de 3000 psi y ha de tener un volumen mínimo de 750 ft^3.

%SOLUTION: 
% The best solution was found in (Ts Th R L) = (0.7500,0.3750,38.4733,227.4036)
% The total cost of the vessel is 5905.779358
% The volume of the vessel is 1296009.025481 (>= 1296000)
% The ratio Ts/R is 0.019894 (>= 0.0193)
% The ratio Th/R is 0.009947 (>= 0.00954)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
restart();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            % PARAMETROS DEL PROBLEMA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q = 10000;
L = 240;
M_max = 1.8e6;
P = 1500;

nvars = 4;      
LB = [0.05 0.05 0.05 0.05];
UB = [10 10 10 120];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         % PARAMETROS DEL ALGORITMO 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Numero de GENERACIONES
numgen = 500;
%Numero de INDIVIDUOS de la poblacion (un numero par)
nindg = 40;
%¿Se aplica elitismo? (1 = sí, 0 = no)
elitismo = 1;
%Número de individuos para TORNEO (2,3,5)
nuintor = 2;
%Probabilidad de CRUCE
pcru = 0.8;
%Probabilidad de Mutacion
pmut = 0.2;
%Rango máximo de la mutacion
maxmut = 0.1;
%¿Cada cuántas iteraciones se escribe en pantalla la mejor solución?
printpant = 10;
%número de ensayos diferentes que se quieren realizar
ensayos = 10;
if ensayos > 1
    printpant = numgen + 1;
end

%matrices y vectores necesarios para el estudio estadístico
best = zeros(ensayos,nvars);
fbest = zeros(1,ensayos);
fworst = zeros(1,ensayos);
fmean = zeros(1,ensayos);
fstd = zeros(1,ensayos);
fmedian = zeros(1,ensayos);
ffeval = zeros(1,ensayos);

disp ('-----------------------------------')
disp ('Execution of the Genetic Algorithm:')
disp ('-----------------------------------')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     % GRAN BUCLE QUE VA GENERANDO LOS ENSAYOS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
contador=1;
while contador<=ensayos
    fprintf('Trial %.d: ',contador);
    
    pop = zeros(nindg,nvars+1); %matriz población con nº filas (cromosomas) = nindg  
                                %nº de columnas = nvar+1:
                                %valor y=f(x) --> pop(i,nvar+1)
    copia = zeros(nindg,nvars+1);
    mejor = zeros(1,nvars+1);   %matriz óptimos locales
    
    [pop] = generar_poblacion_ley_uniforme(nvars,nindg,pop,LB,UB);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                 % G>0 COMIENZA EL ALGORITMO 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    npp = 0; %Contador de generaciones para imprimir en pantalla
    nfmejor = 0;
    for gen=1:numgen
        npp = npp +1;
        %Evaluación de la función objetivo
        [pop] = fitness_function(nvars,nindg,pop, Q, L, P, M_max);
		    
	    %Se ordena de menor a mayor por f(x)(MINIMIZA) y los elitistas se quedan arriba
        %SORTROWS uses a stable version of quicksort.
        pop(1:nindg,:) = sortrows(pop(1:nindg,:),nvars+1);
        
        %Se obtiene el mejor individuo
        [nfmejor, mejor] = obtener_mejor(gen, nvars, nfmejor, pop, mejor);
           
        %Control de elitismo
        if elitismo == 1
            % Aplicamos elitismo
            for nv=1:1:nvars+1
                pop(nindg,nv) = mejor(nv);
            end
            
            %Se ordena de menor a mayor por f(x)(MINIMIZA) y los elitistas se quedan arriba
            %SORTROWS uses a stable version of quicksort.
            pop(1:nindg,:) = sortrows(pop(1:nindg,:),nvars+1);
        end
		     
        %Control de la impresión en pantalla del mejor
        if npp == printpant
            fprintf(' Gen.%d: %.6f\n',gen,pop(1,nvars+1));
            npp = 0;
        end
        
	    %Seleccion: este proceso parte de los individuos de pop,
        %           realiza la selección por torneo y deposita la copia 
        %           de los individuos seleccionados en copia
        [copia] = torneo(nuintor, nvars, nindg, pop, copia);
        
        %Cruce: este proceso parte de los individuos de copia,
        %           los cruza y deposita los nuevos individuos en pop 
        [pop] = cruce(nvars, nindg, pop, copia, LB, UB, pcru);
        
        %Mutación: este proceso muta los individuos de pop
        [pop] = mutacion(nvars, nindg, pop, LB, UB, pmut, maxmut);
    end
    
    %Evaluación de la función objetivo
    [pop] = fitness_function(nvars,nindg,pop, Q, L, P, M_max);
		    
    %Se ordena de menor a mayor por f(x)(MINIMIZA) y los elitistas se quedan arriba
    %SORTROWS uses a stable version of quicksort.
    pop(1:nindg,:) = sortrows(pop(1:nindg,:),nvars+1);
        
    %Se obtiene el mejor individuo
    [nfmejor, mejor] = obtener_mejor(gen, nvars, nfmejor, pop, mejor);
    mostrar_mejor(mejor, Q, L, M_max, P);

    %guardamos los resultados necesarios para el estudio estadístico
    best(contador,:) = mejor(1,1:nvars);
    fbest(contador) = mejor(1,nvars+1);
    fworst(contador) = max(pop(:,nvars+1));
    fmean(contador) = mean(pop(:,nvars+1));
    fstd(contador) = std(pop(:,nvars+1));
    fmedian(contador) = median(pop(:,nvars+1));
    
    contador = contador+1;
end

%-------------------
%Estudio estadístico
%-------------------
if ensayos > 1
    [fvalmin, nmin] = statistics(ensayos, fbest, fworst, fmean, fstd, fmedian);
    fprintf('\n--------------------------------------------');
    fprintf('\nMEJOR SOLUCIÓN GLOBAL ENTRE TODOS LOS ENSAYOS');
    fprintf('\n--------------------------------------------\n');
    mostrar_mejor(best(nmin,:), Q, L, M_max, P);
end