function pop = linRanking(pop,varargin)
% population/linRanking
%
% pop = linRanking(pop,cMult=2)
%
% Implements linear ranking.
%
% See also: tournament, btournament, sus, roulette

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
   cMult = varargin{1};
else
   cMult = 2;
end

if cMult<=1 || cMult>2  
   error('Invalid value of cMult')
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);
fitness = reshape([pop.individual.fitness],k,n)';
[~,I] = sortrows(fitness);

if pop.params.max
   rank(I) = 1:n - 1;
else
   rank(I(n:-1:1)) = 1:n - 1;
end

fp = 2-cMult+2*(cMult-1)*rank'/(n-1);

for i=1:n
   pop.individual(i).fitness(k+1) = fp(i);
end
