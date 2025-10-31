%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ALGORITMO GENETICO: Se quiere construir una vasija de presión cilíndrica 
% tapada por ambos lados con cabezas hemisféricas. El objetivo es minimizar 
% el costo total, incluyendo el costo del material, forma y soldadura. El 
% tanque de almacenamiento de aire ha de soportar una presión de trabajo 
% de 3000 psi y ha de tener un volumen mínimo de 750 ft^3.

%SOLUTION: 
% The best solution was found in (Ts Th R L) = (0.7500,0.3750,38.8598,221.3700)
% The total cost of the vessel is 5850.861314
% The volume of the vessel is 1296000.000000 (>= 1296000)
% The ratio Ts/R is 0.019300 (>= 0.0193)
% The ratio Th/R is 0.009650 (>= 0.00954)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
restart();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            % PARAMETROS DEL PROBLEMA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Numero de variables del problema
nvars = 4;      

% Límites inferior y superior
LB = [12 12 12 12];
UB = [60 60 60 60];

% Longitud de cada gen (número de bits por variable)
lc = zeros(nvars,1);

% Variables enteras (i=1,2)
for i=1:nvars
    lc(i) = ceil(log10(UB(i)-LB(i))/log10(2));
end

% Variables reales (i=3,4)
% pr = 6; % precisión (cifras decimales)
% for i=3:nvars
%     lc(i) = ceil(log10((UB(i)-LB(i))*10^pr)/log10(2));
% end

% Longitud total del cromosoma
lctotal = sum(lc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         % PARAMETROS DEL ALGORITMO 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Numero de GENERACIONES
numgen = 500;
%Numero de INDIVIDUOS de la poblacion (un numero par)
nindg = 100;
%¿Se aplica elitismo? (1 = sí, 0 = no)
elitismo = 1;
%Número de individuos para TORNEO (2,3,5)
nuintor = 2;
%Probabilidad de CRUCE
pcru = 0.8;
%Probabilidad de Mutacion
pmut = 1/lctotal;
%¿Cada cuántas iteraciones se escribe en pantalla la mejor solución?
printpant = 1;
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
    fprintf('Trial %.d: \n',contador);
    
    %Generación de la población inicial
    pop = randi([0 1], nindg, lctotal, 'logical');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                 % G>0 COMIENZA EL ALGORITMO 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    npp = 0; %Contador de generaciones para imprimir en pantalla
    nfmejor = 0;
    fmejor = 1.e20;
    mejor = pop(1,:);
    for gen=1:numgen
        npp = npp +1;
        %Evaluación de la función objetivo
        fval = fitness_function(nvars, nindg, pop, lc, LB, UB);
		    
	    %Se ordena de menor a mayor por f(x)(MINIMIZA) y los elitistas se quedan arriba
        %SORTROWS uses a stable version of quicksort.
        [fval,index] = sortrows(fval);
        pop = pop(index,:);
        
        %Se obtiene el mejor individuo
        if fval(1) < fmejor
            nfmejor = gen;
            mejor = pop(1,:);
            fmejor = fval(1);
        end
           
        %Control de elitismo
        if elitismo == 1
            % Aplicamos elitismo
            pop(2:nindg,:) = pop(1:nindg-1,:);
            fval(2:nindg) = fval(1:nindg-1);
            pop(1,:) = mejor;
            fval(1) = fmejor;
        end
		     
        %Control de la impresión en pantalla del mejor
        if npp == printpant
            fprintf(' Gen.%d: %.12e\n',gen,fmejor);
            npp = 0;
        end
        
	    %Seleccion: este proceso parte de los individuos de pop,
        %           realiza la selección por torneo y deposita la copia 
        %           de los individuos seleccionados en copia
        [copia] = torneo(nuintor, lctotal, nindg, pop);
        
        %Cruce: este proceso parte de los individuos de copia,
        %           los cruza y deposita los nuevos individuos en pop 
        pop = cruce(copia, pcru);
        
        %Mutación: este proceso muta los individuos de pop
        pop = mutacion(pop, pmut);
    end
    
    %Evaluación de la función objetivo
    fval = fitness_function(nvars, nindg, pop, lc, LB, UB);
		    
    %Se ordena de menor a mayor por f(x)(MINIMIZA) y los elitistas se quedan arriba
    %SORTROWS uses a stable version of quicksort.
    [fval,index] = sortrows(fval);
    pop = pop(index,:);
        
    %Se obtiene el mejor individuo
    if fval(1) < fmejor
        nfmejor = gen;
        mejor = pop(1,:);
        fmejor = fval(1);
    end
    mostrar_mejor(decode(mejor, nvars, lc, LB, UB));

    %guardamos los resultados necesarios para el estudio estadístico
    best(contador,:) = decode(mejor, nvars, lc, LB, UB);
    fbest(contador) = fmejor;
    fworst(contador) = max(fval);
    fmean(contador) = mean(fval);
    fstd(contador) = std(fval);
    fmedian(contador) = median(fval);
    
    contador = contador+1;
end

%-------------------
%Estudio estadístico
%-------------------
if ensayos > 1
    [fvalmin,nmin] = statistics(ensayos,fbest,fworst,fmean,fstd,fmedian);
    mostrar_mejor(best(nmin,:));
end