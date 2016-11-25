function pop = randomPerm(pop,n,varargin)
% population/randomPerm
%
% pop = randomPerm(pop,n,add='N')
%
% Generates a random population of size n, where individuals are random
% permutations in [0..n-1].  If add='Y' it appends the random individuals 
% to the existing population.

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
   ad = varargin{1};
else
   ad = 'N';
end
if isequal(ad,'Y') || isequal(ad,'y') || isequal(ad,'YES') || ...
      isequal(ad,'Yes') || isequal(ad,'yes')
elseif isequal(ad,'N') || isequal(ad,'n') || isequal(ad,'NO') || ...
      isequal(ad,'No') || isequal(ad,'no')
   pop.individual = [];
else
   error(['add=' add ' not valid'])
end

m = pop.params.m;

% These fields are the same for all new individuals
p.fitness = NaN;
if pop.params.inheritance
   p.fTrue = NaN;
   p.fEsti = NaN;
   p.iCtrl = 1;
end

if isequal(pop.params.type,'integer')
   for i=1:n,
      p.r = randperm(m)-1;
      % pop.individual(i) = p;
      pop.individual = [pop.individual p];
   end
else
   error(strcat(pop.params.type, ' is not a valid type of population for randomPerm'))
end
