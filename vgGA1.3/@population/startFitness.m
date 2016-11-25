function pop = startFitness(pop,varargin)

% population/startFitness
%
% pop = startFitness(pop,omega0=0,delta0=0)
%
% For use with MOO. Sets omega and delta of newly born individual 
% to given values.
%
% See also: population/resetFitness

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
   omega0 = varargin{1};
else
   omega0 = 0;
end
if length(varargin)>=2
   delta0 = varargin{1};
else
   delta0 = 0;
end
fitLen = pop.params.noFunctions;
pop.individual(length(pop.individual)).fitness(fitLen+1:fitLen+3) = ...
   [omega0 delta0 0];

