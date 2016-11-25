function pop = multiEvaluate(pop,objective_functions,varargin)

% population/multiEvaluate
%
% pop = multiEvaluate(pop,objective_functions,start=1)
%
% Evaluates population with a list of objective_functions
%
% See also: evaluate, evaluateLast, multiEvaluateLast
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
   start = varargin{1};
else
   start = 1;
end

n = length(pop.individual);
pop.params.noFunctions = length(objective_functions);
for i=start:n
   fitness = [];
   if isnan(pop.individual(i).fitness)
      for j=1:pop.params.noFunctions
         fitness(j) = feval(objective_functions{j}, pop.individual(i).r);
      end
      pop.individual(i).fitness = fitness;
      pop.evals = pop.evals + 1;
   else
      pop.individual(i).fitness = ...
         pop.individual(i).fitness(1:pop.params.noFunctions);
   end
   if pop.params.inheritance
      pop.individual(i).fTrue = pop.individual(i).fitness;
   end
end
