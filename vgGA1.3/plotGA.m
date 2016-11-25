function [x,prom,desv] = plotGA(n,generations,popsize,obj,seed,type,varargin)
% [x,prom,desv] = plotGA(n,generations,popsize,obj_fcn,seed,
%                        'integer',N,pm,pc,B,delta,dist,digits)
% [x,prom,desv] = plotGA(n,generations,popsize,obj_fcn,seed,
%                        'real',R,N,pm,pc,B,delta,dist,digits)
%
% This function repeatedly calls runGA to generate a 
% best-found curve, where n is the number of runs to be
% performed and seed is the random generator seed. 
% See population for a description of the parameters.
%
% See also: population, runGA
  
%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnológico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

DISPLAY_POP = 0; % Display final population after each run?
  
  
if isequal(seed,'random')
   seed = sum(100*clock);
end

fprintf(1,'\n*** Starting run #1 ***\n')
p = createPop(type,varargin);
p = random(p,popsize);
[p,B] = runGA(p,obj,generations);
if DISPLAY_POP
  display(p);
end
X = B(:,1)';
x = X;
Y = B(:,2)';
for i=2:n
   fprintf(1,'\n*** Starting run #%d ***\n', i)
   p = createPop(type,varargin);
   p = random(p,popsize);
   [p,B] = runGA(p,obj,generations);
   if DISPLAY_POP
     display(p);
   end
   %x = B(:,1);
   y = B(:,2)';
   Y = [Y; y];
end
prom = mean(Y);
desv = std(Y);
maxi = max(Y);
mini = min(Y);
if prom(1) <= prom(length(prom))
  best = max(maxi);
else
  best = min(mini);
end

fprintf('\n *** best fitness found = %f ***\n', best)
plot(X,prom+desv,X,prom,X,prom-desv)
legend('average + std dev','average','average - std dev',0)
%%%%%   If you prefer to plot min, average, and max uncomment the 
%%%%%   following two lines and comment the previous two lines
%plot(X,mini,X,prom,X,maxi)
%legend('minimal','average','maximal')

if isa(obj,'function_handle')
   obj = func2str(obj);
end
title(['Best-so-far curve for obj function "',obj,'"'])
ylabel('best found')
xlabel('number of obj function evaluations')





function p = createPop(type,v);
switch length(v)
case 0
   p = population(type);
case 1
   p = population(type,v{1});
case 2
   p = population(type,v{1},v{2});
case 3
   p = population(type,v{1},v{2},v{3});
case 4
   p = population(type,v{1},v{2},v{3},v{4});
case 5
   p = population(type,v{1},v{2},v{3},v{4},v{5});
case 6
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6});
case 7
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6},v{7});
otherwise
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6},v{7},v{8});
end
