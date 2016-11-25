function pop = evaluateLast(pop,objective_function,varargin)

% population/evaluateLast
%
% pop = evaluateLast(pop,objective_function,N=1,setBestFlag=1)
%
% Evaluate the last N individuals in the population.

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnologico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

if length(varargin)>=1
   N = varargin{1};
else
   N = 1;
end

if length(varargin)>=2
   setBestFlag = varargin{2};
else
   setBestFlag = 1;
end
n = length(pop.individual);

for i=n-N+1:n
   if isnan(pop.individual(i).fitness)
      pop.individual(i).fitness = ...
         feval(objective_function, pop.individual(i).r);
      pop.evals = pop.evals + 1;
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
