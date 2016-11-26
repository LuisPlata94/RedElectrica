%% Datos caso 1

% hijo del nodo i-1
%       0 1 2 3 4 5 6
hijo = [0 5 4 6 1 5 6];
hijo = [0 4 4 1 4 4 4];

% Producción del nodo i-1
%       0 1 2 3 4 5 6
prod = [0 10 5 3 4 9 8];

% Coordenadas del nodo i-1
%     0   1   2   3   4    5    6
C = [0 0;3 2;6 2;6 0;3 -2;6 -2;9 -2];

l = length(hijo);

%% Algorimo genético
objF = @(x) costored1(x);

N = 3*ones(1,l);             % longitud del cromosoma
n = 20;             % tamaño de población
generaciones = 100; % generaciones que correrá el AG
p = population('integer',N,0.1,0.9);
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