function pop = random(pop,n,varargin)
% population/random
%
% pop = random(pop,n,add='N')
%
% Generates a random population of size n. If add='Y' it appends the
% random individuals to the existing population.

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

% These fields are the same for all new individuals
p.fitness = NaN;
if pop.params.inheritance
   p.fTrue = NaN;
   p.fEsti = NaN;
   p.iCtrl = 1;
end

if isequal(pop.params.type,'integer')
   for i=1:n,
      for j=1:pop.params.m,
         p.r(j) = floor(pop.params.B(j)^pop.params.N(j)*rand);
      end
      % pop.individual(i) = p;
      pop.individual = [pop.individual p];
   end
elseif isequal(pop.params.type,'real')
   if ~isequal(pop.params.digits,'continuous')
      for i=1:n,
         for j=1:pop.params.m,
            p.r(j) = floor(pop.params.B(j)^pop.params.N(j)*rand);
            p.r(j) = pop.params.DeltaR(j)*p.r(j)/...
               pop.params.B(j)^pop.params.N(j)+...
               pop.params.rMin(j);
         end
         pop.individual = [pop.individual p];
      end
   else
      for i=1:n,
         for j=1:pop.params.m,
            p.r(j) = pop.params.DeltaR(j)*rand + pop.params.rMin(j);
         end
         % pop.individual(i) = p;
         pop.individual = [pop.individual p];
      end
   end
else
   error(strcat(type, ' is not a valid type of population'))
end
