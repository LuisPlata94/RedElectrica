function pop = evaluateInheritance(pop,objective_function,varargin)
% population/evaluate
%
% pop = evaluate(pop,objective_function,type='fixed')
%
% Evaluates population with objective_function and inheritance of type
% type: 'c(onfidance)' 'e(rror)' 'f(ixed)' (default)

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
   type = varargin(1);
else
   type = 'fixed';
end

if isequal(type,'fixed') || isequal(type,'f') || isequal(type,'F')
   type = 'fixed';
elseif isequal(type,'c') || isequal(type,'C')
   type = 'confidance';
elseif isequal(type,'e') || isequal(type,'E')
   type = 'error';
else
   error(strcat(type, ' is not an implemented type of inheritance'))
end

if isequal(type,'error')
   error('error controlled inheritance is not implemented yet')
end


n = length(pop.individual);

k = length(pop.individual(1).iCtrl);
iCtrl = reshape([pop.individual.iCtrl],k,n)';
[Y,I] = sortrows(iCtrl);
pop.individual = pop.individual(I);

if isequal(type,'fixed')   
   last = n*pop.params.alpha;
elseif isequal(type,'confidance')
   ind = find(Y<pop.params.minConfidance);
   last = ind(length(ind));
   pop.params.alpha = last/n;
end

for i=1:last,
   pop.individual(i).fitness = ...
      feval(objective_function, pop.individual(i).r);
   pop.evals = pop.evals + 1;
   if pop.params.inheritance
      pop.individual(i).fTrue = pop.individual(i).fitness;
      pop.individual(i).iCtrl = 1;
   end
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

if pop.params.inheritance
   fTrue = reshape([pop.individual.fTrue],k,n)';
   fTrue = fTrue(1:last);
   fEsti = reshape([pop.individual.fEsti],k,n)';
   fEsti = fEsti(1:last);
   pop.params.error = mean((fTrue-fEsti).^2./fTrue);
end
