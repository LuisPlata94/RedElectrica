clear; clc; clf;

global N D prod caso nbits

caso=1; % Cambiar este numero de acuerdo al caso a analizar
switch caso
    % Producción del nodo i-1
    % Coordenadas del nodo i-1
    case 1
        prod = [0 10 5 3 4 9 8];
        C = [0 0;3 2;6 2;6 0;3 -2;6 -2;9 -2];
        ts='Caso 1';
        disp('Caso 1 cargado')
    case 2
        prod = [0 3 3 3 10 4 5 5 14 12 2];
        C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2; 4 2; 1 3; 3 3; 5 3];
        ts='Caso 2';
        disp('Caso 2 cargado')
    case 3
        prod = [0 3 3 3 10 4 5 5 14 12 2 5 8 10 13];
        C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2;...
            4 2; 1 3; 3 3; 5 3; 5 1;5 2;0 0;0 3];
        ts='Caso 3';
        disp('Caso 3 cargado')
end

N = length(prod); D = zeros(N);
for i=1:N
    for j=i+1:N
        D(i,j) = norm(C(i,:)-C(j,:));
        D(j,i) = D(i,j);
    end
end

%Iniciar el algorimo genético
objF = @(x) costored(x);

% l te dice el numero de bits y segmentos necesarios para el cromosoma
% no se toma en cuenta al 0 que va por default al principio de cada hijo
nbits = ceil(log2(N-1));
l = nbits*ones(1,N-1);
n = 20;             % tamaño de población
% Generaciones que correrá el AG, depende del caso
switch caso
    case 1
        generaciones = 100;
    case 2
        generaciones = 125;
    case 3
        generaciones = 160;
end
%% Curva mejor encontrado
[x,prom,desv,p]=plotGA(20,generaciones,n,objF,'5980',...
    'integer',l,0.1,0.9);
title(['Curva del mejor encontrado para ' ts])
best=get(p,'best');
hijo = [0,transhijo(best.r+1)];
%% Gráfica de la red con producción
clf;

% Conversión de padre a matriz de incidenciass
A = zeros(N);
for i=1:N
   if hijo(i)~=0
      A(i,hijo(i)) = 1;
   end
end

% Cálculo de corriente en cada arista del árbol
Aux = A;
envia = zeros(size(hijo));    % potencia que envía cada nodo a su padre
while 1
   hojas = find(sum(Aux,1)==0);  % si el nodo raíz es hoja,
   if isequal(hojas,1)           % salir
      break
   end
   envia(hojas) = envia(hojas) + prod(hojas);  
   for i=1:length(hojas)
      envia(hijo(hojas(i))) = envia(hijo(hojas(i))) + envia(hojas(i));
      Aux(hojas(i),:) = zeros(size(hijo));
   end
   Aux(1,hojas) = 1;
end

% Gráfica de red con producción y cantidad que se envía
delta = 0.15; % desplazamiento de las etiquetas
plot(C(1,1),C(1,2),'sr',C(2:end,1),C(2:end,2),'ob')
xlim([min(C(:,1))-0.5 max(C(:,1)+1)]);
ylim([min(C(:,2))-0.5 max(C(:,2)+0.5)]);
hold on
for p=2:N
   h = hijo(p);
   text(C(p,1)+delta,C(p,2)+delta,sprintf('%d:%d/%d',p-1,prod(p),envia(p)))
   plot([C(p,1) C(h,1)],[C(p,2) C(h,2)],'-b')
end
text(C(1,1)+delta,C(1,2)+delta,'0')
hold off
title(['Red eléctrica (nodo:producción/envía) '...
    ts ', costo = ' sprintf('%0.3f',best.fitness)])
xlabel('x')
ylabel('y')

%% Correrlo 1 sola vez
p = population('integer',l,0.1,0.9);
p = random(p,n);
p = evaluate(p,objF);
best = get(p,'best');
e = 0;
b = best.fitness;
for i=1:generaciones
    p = tournament(p);
    p = crossover(p);
    p = mutation(p);
    p = evaluate(p,objF);
    best = get(p,'best');
    e(i+1) = get(p,'evals');
    b(i+1) = best.fitness;
    plot(e,b,'.-')
    %axis([0 e(i+1)+100 0 ceil(logB(2^N,B))])
    xlabel('Evaluaciones de la función objetivo')
    ylabel('Mejor encontrado')
    %title(sprintf('AG simple (n=%d) sobre basemax (B=%d,N=%d)',n,B,N))
    pause(0.01)
end