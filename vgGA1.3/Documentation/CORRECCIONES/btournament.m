function pop = btournament(pop, compare_function)
% POPULATION/BTOURNAMENT
%
% pop = btournament(pop, compare_function)
%
% Implements binary tournament selection with a user provided
% function that compares two individuals and returns true if
% the first individual is beter or equal than the second individual.
%
% See also: roulette, sus, tournament

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Departamento de Mecatrónica y Automatización           *
%*   Tecnológico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

n = length(pop.individual);
pop.individual = [pop.individual pop.individual(1)];

ind = [randperm(n) n+1];
pop.individual = [pop.individual pop.individual(ind(1))];
for i=1:n
   if feval(compare_function,pop.individual(ind(i)).r,pop.individual(ind(i+1)).r)
      pop.individual(ind(i)) = pop.individual(ind(i));
   else
      pop.individual(ind(i)) = pop.individual(ind(i+1));
   end
end
pop.individual = pop.individual(1:n);

