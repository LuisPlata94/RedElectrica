%% Ejemplo de cardinalidad de código
% Vamos a comparar el desempeño de un AG con código binario y uno con
% código octal para el mismo problema. (Problema G, pag. 88, libro de 
% texto de Golbderg)

%% Función objetivo

f10 = @(x) x.^10/((2^30-1)^10)
x = 0:2^20:2^30-1;
plot(x,f10(x))
xlabel('x')
ylabel('f(x)')

%% Una sola corrida de cada algoritmo
% p2: población binaria, p8: población octal

generaciones = 30;
pc = 1;
pm8 = 0;
pm2 = pm8/3;
n = 100;              % tamaño de la población
p2 = population('integer',30,pm2,pc,2); % cromosomas binarios
p8 = population('integer',10,pm8,pc,8); % cromosomas octales
p2 = random(p2,n);
p8 = random(p8,n);
p2 = evaluate(p2,f10);
p8 = evaluate(p8,f10);
best2 = get(p2,'best');
best8 = get(p8,'best');
e2 = 0;
e8 = 0;
b2 = best2.fitness;
b8 = best8.fitness;
for i=1:generaciones
   p2 = sus(p2);      % selección SUS
   p8 = sus(p8);      % selección SUS
   p2 = crossover(p2);
   p8 = crossover(p8);
   p2 = mutation(p2);
   p8 = mutation(p8);
   p2 = evaluate(p2,f10);
   p8 = evaluate(p8,f10);
   best2 = get(p2,'best');
   best8 = get(p8,'best');
   e2(i+1) = get(p2,'evals');
   e8(i+1) = get(p8,'evals');
   b2(i+1) = best2.fitness;
   b8(i+1) = best8.fitness;
   plot(e2,b2,'b.-',e8,b8,'r.-')
   axis([0 max(max([e2 e8])) 0.80 1.05])
   xlabel('Evaluaciones de la función objetivo')
   ylabel('Mejor encontrado')
   title('Comparación de AG binario y octal')
   legend('binario','octal')
   pause(0.01)
end

%% Curvas del mejor encontrado

corridas = 100;
E2 = [];    
Be2 = [];
E8 = [];    
Be8 = [];
p2 = population('integer',30,pm2,pc,2); % cromosomas binarios
p8 = population('integer',10,pm8,pc,8); % cromosomas octales
for j=1:corridas
   p2 = init(p2);
   p8 = init(p8);
   p2 = random(p2,n);
   p8 = random(p8,n);
   p2 = evaluate(p2,f10);
   p8 = evaluate(p8,f10);
   best2 = get(p2,'best');
   best8 = get(p8,'best');
   e2 = get(p2,'evals');
   e8 = get(p8,'evals');
   b2 = best2.fitness;
   b8 = best8.fitness;
   for i=1:generaciones
      p2 = sus(p2);         % selección SUS
      p8 = sus(p8);         % selección SUS
      p2 = crossover(p2);
      p8 = crossover(p8);
      p2 = mutation(p2);
      p8 = mutation(p8);
      p2 = evaluate(p2,f10);
      p8 = evaluate(p8,f10);
      best2 = get(p2,'best');
      best8 = get(p8,'best');
      e2(i+1) = get(p2,'evals');
      e8(i+1) = get(p8,'evals');
      b2(i+1) = best2.fitness;
      b8(i+1) = best8.fitness;
   end
   E2 = [E2 e2'];
   E8 = [E8 e8'];
   Be2 = [Be2 b2'];
   Be8 = [Be8 b8'];
   x2 = max(E2,[],2);
   x8 = max(E8,[],2);
   prom2 = mean(Be2,2);
   prom8 = mean(Be8,2);
   fig2 = std(Be2,[],2);
   fig8 = std(Be8,[],2);
   plot(x2,prom2+fig2,'b',x2,prom2,'.-b',x2,prom2-fig2,'b',e2,b2,'-.b',...
      x8,prom8+fig8,'r',x8,prom8,'.-r',x8,prom8-fig8,'r',e8,b8,'-.r')
   axis([0 max(max([E2 E8])) 0.80 1.05])
   xlabel('Evaluaciones de la función objetivo')
   ylabel('Mejor encontrado')
   title(sprintf('Comparación AG binario (2) y octal (8) para %d corridas',j))
   legend('prom2 + std dev','prom2','prom2 - std dev','ultima corrida2',...
      'prom8 + std dev','prom8','prom8 - std dev','ultima corrida8',4)
   pause(0.01)
end
plot(x2,prom2+fig2,'b',x2,prom2,'.-b',x2,prom2-fig2,'b',...
   x8,prom8+fig8,'r',x8,prom8,'.-r',x8,prom8-fig8,'r')
axis([0 max(max([E2 E8])) 0.80 1.05])
xlabel('Evaluaciones de la función objetivo')
ylabel('Mejor encontrado')
title(sprintf('Comparación AG binario (2) y octal (8) para %d corridas',j))
legend('prom2 + std dev','prom2','prom2 - std dev',...
   'prom8 + std dev','prom8','prom8 - std dev',4)


   