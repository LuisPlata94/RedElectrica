function pop = inversion(pop,pi,varargin)

% population/mutation
%
% pop = mutation(pop,pi,last=0)
%
% Applies inversion with a probability of pi to the members of a 
% population. The flag last is used to implement a steady state algorithm; 
% inversion is applied to the last individual in the population.

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


if pop.params.pm <= 0
   return
end

if length(varargin)>=1
   last = varargin{1};
else
   last = 0;
end

if last
   start = length(pop.individual);
else
   start = 1;
end

fLen = length(pop.individual(1).fitness);
k = length(pop.individual(1).fitness);

for i=start:length(pop.individual)
   r = pop.individual(i).r;
   if rand <= pi
      pop.individual(i).r = invTSP(r);
      % set fitness to NaN, if individual is changed
      if ~isequal(r,pop.individual(i).r)
         pop.individual(i).fitness = ones(1,fLen)*NaN;
      end
   end
end


 
