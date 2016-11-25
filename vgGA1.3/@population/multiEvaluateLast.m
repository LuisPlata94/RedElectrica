function pop = multiEvaluateLast(pop,objective_functions,varargin)

% population/multiEvaluateLast
%
% pop = multiEvaluateLast(pop,objective_functions,N=1)
%
% Evaluate the last N individuals in the population with a list of
% objective_functions
%
% see also: evaluate, multiEvaluate, evaluateLast
% USE WITH CAUTION: UNDER CONSTRUCTION

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
   N = varargin{1};
else
   N = 1;
end

n = length(pop.individual);
pop.params.noFunctions = length(objective_functions);

for i=n-N+1:n
   fitness = [];
   if isnan(pop.individual(i).fitness)
      for j=1:pop.params.noFunctions
         fitness(j) = feval(objective_functions{j}, pop.individual(i).r);
      end
         pop.individual(i).fitness = fitness;
      pop.evals = pop.evals + 1;
   end
   if pop.params.inheritance
      pop.individual(i).fTrue = pop.individual(i).fitness;
   end
end
