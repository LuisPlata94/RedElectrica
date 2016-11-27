clear; clc; clf;

global N D prod caso nbits

caso=2; % Cambiar este numero de acuerdo al caso a analizar
switch caso
    % Producción del nodo i-1
    % Coordenadas del nodo i-1
    case 1
        prod = [0 10 5 3 4 9 8];
        C = [0 0;3 2;6 2;6 0;3 -2;6 -2;9 -2];
    case 2
        prod = [0 3 3 3 10 4 5 5 14 12 2];
        C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2; 4 2; 1 3; 3 3; 5 3];
    case 3
        prod = [0 3 3 3 10 4 5 5 14 12 2 5 8 10 13];
        C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2;...
            4 2; 1 3; 3 3; 5 3; 5 1;5 2;0 0;0 3];
end

%hijo= randi([1,N],1,N-1)

N = length(prod); D = zeros(N);
for i=1:N
   for j=i+1:N
      D(i,j) = norm(C(i,:)-C(j,:));
      D(j,i) = D(i,j);
   end
end

%% Algorimo genético
objF = @(x) costored(x);

% l te dice el numero de bits y segmentos necesarios para el cromosoma
% no se toma en cuenta al 0 que va por default al principio de cada hijo
nbits = ceil(log2(N-1));
l = nbits*ones(1,N-1);
n = 20;             % tamaño de población
generaciones = 100; % generaciones que correrá el AG
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

%% Gráfica de la red con producción
clf;
hijo = [0,transhijo(best.r+1)];
delta = 0.1; % deplazamiento de las etiquetas
plot(C(1,1),C(1,2),'sr',C(2:end,1),C(2:end,2),'ob')
xlim([min(C(:,1))-0.5 max(C(:,1)+0.5)]);
ylim([min(C(:,2))-0.5 max(C(:,2)+0.5)]);
hold on
for p=2:N
   h = hijo(p);
   %fprintf('p=%d h=%d\n',p,h)
   text(C(p,1)+delta,C(p,2)+delta,sprintf('%d:%d',p-1,prod(p)))
   plot([C(p,1) C(h,1)],[C(p,2) C(h,2)],'-b')
   %pause
end
text(C(1,1)+delta,C(1,2)+delta,'0')
hold off
title('Red eléctrica (nodo:producción)')
xlabel('x')
ylabel('y')