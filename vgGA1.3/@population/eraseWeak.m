function pop = eraseWeak(pop,varargin)
% population/eraseWeak
%
% pop = eraseWeak(pop,N=1)
%
% Erases the weakest N individuals in the population.

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

for i=1:N
   n = length(pop.individual);
   k = length(pop.individual(1).fitness);
   fitness = reshape([pop.individual.fitness],k,n)';
   f = fitness(:,k);
   if pop.params.max
      kill = find(f==min(f));
   else
      kill = find(f==max(f));
   end
   keep = find((1:n)~=kill(1));
   pop.individual = pop.individual(keep);
end
