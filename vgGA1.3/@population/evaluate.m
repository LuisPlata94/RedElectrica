function pop = evaluate(pop,objective_function,varargin)
% population/evaluate
%
% pop = evaluate(pop,objective_function,start=1,setBestFlag=1)
%
% Evaluates population with objective_function

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

if length(varargin)>=1
   start = varargin{1};
else
   start = 1;
end

if length(varargin)>=2
   setBestFlag = varargin{2};
else
   setBestFlag = 1;
end
n = length(pop.individual);
for i=start:n,
   if isnan(pop.individual(i).fitness)
      pop.individual(i).fitness = ...
         feval(objective_function, pop.individual(i).r);
      pop.evals = pop.evals + 1;
   else
      pop.individual(i).fitness = ...
         pop.individual(i).fitness(1);  % only keep first component of fitness
   end
   if pop.params.inheritance
      pop.individual(i).fTrue = pop.individual(i).fitness;
   end
   if setBestFlag
      if pop.params.max == 1
         if pop.individual(i).fitness(1) > pop.best.fitness(1)
            pop.best.fitness(1) = pop.individual(i).fitness(1);
            pop.best.r = pop.individual(i).r;
            pop.best.evals = pop.evals;
         end
      else
         if pop.individual(i).fitness(1) < pop.best.fitness(1)
            pop.best.fitness(1) = pop.individual(i).fitness(1);
            pop.best.r = pop.individual(i).r;
            pop.best.evals = pop.evals;
         end
      end
   end
end
