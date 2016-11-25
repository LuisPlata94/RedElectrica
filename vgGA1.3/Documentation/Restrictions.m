%% Restricciones
% NO FUNCIONA
% Optimicemos la función 2 de Deb |debf2| con la restricción de que x>0.35




%% AG con letales
t = [0:0.01:1];
p = population('real',[0 1],30,0,0.9);
p = random(p,100);
generaciones = 20;
p = evaluate(p,@debf2L);
for i=1:generaciones
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf2L);
   pp = evaluate(p,@debf2);
   plot(t,debf2(t))
   axis([0 1 -0.1 1.1])
   hold on
   plot(pp);
   str = sprintf('t = %d',i);
   text(0.7,0.8,str)
   hold off
   pause(0.05)
end

%% AG con función de castigo
t = [0:0.01:1];
p = population('real',[0 1],30,0,0.9);
p = random(p,100);
generaciones = 20;
p = evaluate(p,@debf2C);
for i=1:generaciones
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf2C);
   pp = evaluate(p,@debf2);
   plot(t,debf2(t))
   axis([0 1 -0.1 1.1])
   hold on
   plot(pp);
   str = sprintf('t = %d',i);
   text(0.7,0.8,str)
   hold off
   pause(0.05)
end