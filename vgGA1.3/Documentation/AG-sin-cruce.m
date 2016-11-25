%% AG sin cruce
% Vamos a comparar el desempeño de un AG simple y un AG simple sin cruce.

%% Función objetivo

% Sobre esta función es mejor al AG sin cruce
% clear objF
% objF = @(x) 4*(x-0.5).^2;

% Sobre esta función es mejor el AG con cruce
B0 = 2;
clear objF
objF = @(x) basemax(x,B0);

%% Un AG Simple sobre basemax

B = 2;
N = 30;             % longitud del cromosoma
n = 30;             % tamaño de población
generaciones = 30; % generaciones que correrá el AG
p1 = population('i',N,0.0,0.9,B); % solo cruce
p2 = population('i',N,1.0,0,B);   % solo mutación
p1 = random(p1,n);
p2 = random(p2,n);
p1 = evaluate(p1,objF);
p2 = evaluate(p2,objF);
best1 = get(p1,'best');
best2 = get(p2,'best');
e1 = 0;
e2 = 0;
b1 = best1.fitness;
b2 = best2.fitness;
for i=1:generaciones
   p1 = tournament(p1);
   p2 = tournament(p2);
   p1 = crossover(p1);
   %p2 = crossover(p2);
   %p1 = mutation(p1);
   p2 = mutation(p2);
   p1 = evaluate(p1,objF);
   p2 = evaluate(p2,objF);
   best1 = get(p1,'best');
   best2 = get(p2,'best');
   e1(i+1) = get(p1,'evals');
   e2(i+1) = get(p2,'evals');
   b1(i+1) = best1.fitness;
   b2(i+1) = best2.fitness;
   plot(e1,b1,'b.-',e2,b2,'r.-')
    axis([0 e1(i+1)+100 0 ceil(logB(B^N,B0))+1])
   legend('solo cruce','solo mutación','location','best')
   xlabel('Evaluaciones de la función objetivo')
   ylabel('Mejor encontrado')
   title(sprintf('AG simple (n=%d)',n))
   pause(0.01)
end


%%
corridas = 100;
E1 = [];    
Be1 = [];
E2 = [];    
Be2 = [];
p1 = population('i',N,0.0,0.7,B); % solo cruce
p2 = population('i',N,0.8,0,B);   % solo mutación
for j=1:corridas
   p1 = init(p1);
   p2 = init(p2);
   p1 = random(p1,n);
   p2 = random(p2,n);
   p1 = evaluate(p1,objF);
   p2 = evaluate(p2,objF);
   best1 = get(p1,'best');
   best2 = get(p2,'best');
   e1 = get(p1,'evals');
   e2 = get(p2,'evals');
   b1 = best1.fitness;
   b2 = best2.fitness;
   for i=1:generaciones
      p1 = tournament(p1);         
      p2 = tournament(p2);         
      p1 = crossover(p1);
      p2 = crossover(p2);
      p1 = mutation(p1);
      p2 = mutation(p2);
      p1 = evaluate(p1,objF);
      p2 = evaluate(p2,objF);
      best1 = get(p1,'best');
      best2 = get(p2,'best');
      e1(i+1) = get(p1,'evals');
      e2(i+1) = get(p2,'evals');
      b1(i+1) = best1.fitness;
      b2(i+1) = best2.fitness;
   end
   E1 = [E1 e1'];
   E2 = [E2 e2'];
   Be1 = [Be1 b1'];
   Be2 = [Be2 b2'];
   x1 = max(E1,[],2);
   x2 = max(E2,[],2);
   prom1 = mean(Be1,2);
   prom2 = mean(Be2,2);
   fig1 = std(Be1,[],2);
   fig2 = std(Be2,[],2);
   plot(x1,prom1+fig1,'b',x1,prom1,'.-b',x2,prom1-fig1,'b',e1,b1,'-.b',...
      x2,prom2+fig2,'r',x2,prom2,'.-r',x2,prom2-fig2,'r',e2,b2,'-.r')
   %axis([0 max(max([E1 E2])) 0.80 1.05])
   xlabel('Evaluaciones de la función objetivo')
   ylabel('Mejor encontrado')
   title(sprintf('Comparación AG binario (2) y octal (8) para %d corridas',j))
   legend('prom2 + std dev','prom2','prom2 - std dev','ultima corrida2',...
      'prom8 + std dev','prom8','prom8 - std dev','ultima corrida8',4)
   pause(0.01)
end
plot(x1,prom1+fig1,'b',x1,prom1,'.-b',x1,prom1-fig1,'b',...
   x2,prom2+fig2,'r',x2,prom2,'.-r',x2,prom2-fig2,'r')
axis([0 max(max([E1 E2])) 0.80 1.05])
xlabel('Evaluaciones de la función objetivo')
ylabel('Mejor encontrado')
title(sprintf('Comparación AG binario (2) y octal (8) para %d corridas',j))
legend('prom2 + std dev','prom2','prom2 - std dev',...
   'prom8 + std dev','prom8','prom8 - std dev',4)


%% Curva del mejor encontrado
% Para generar la curva del mejor encontrado, corremos múltiples veces
% el AG simple.

corridas = 100;
generaciones = 40;
N = 30;                % longitud del cromosoma
n = 10;                % tamaño de la población
E = [];    
Be = [];
p = population('integer',N,0.1,0.7);
for j=1:corridas
   p = init(p);
   p = random(p,n);
   p = evaluate(p,objF);
   best = get(p,'best');
   e = get(p,'evals');
   b = best.fitness;
   for i=1:generaciones
      p = tournament(p);
      p = crossover(p);
      p = mutation(p);
      p = evaluate(p,objF);
      best = get(p,'best');
      e(i+1) = get(p,'evals');
      b(i+1) = best.fitness;
   end
   E = [E e'];
   Be = [Be b'];
   x = max(E,[],2);
   prom = mean(Be,2);
   fig1 = std(Be,[],2);
   plot(x,prom+fig1,x,prom,'.-',x,prom-fig1,e,b,'-.k')
   axis([0 max(max(E)) 0 ceil(logB(2^N,B))])
   xlabel('Evaluaciones de la función objetivo')
   ylabel('Mejor encontrado')
   title(sprintf('Curva del mejor encontrado para %d corridas',j))
   legend('prom + std dev','prom','prom - std dev','ultima corrida',0)
   pause(0.01)
end
plot(x,prom+fig1,x,prom,'.-',x,prom-fig1)
% axis([0 max(max(E)) 0 ceil(logB(2^N,B))])
xlabel('Evaluaciones de la función objetivo')
ylabel('Mejor encontrado')
title(sprintf('Curva del mejor encontrado para %d corridas',j))
legend('prom + std dev','prom','prom - std dev',0)
