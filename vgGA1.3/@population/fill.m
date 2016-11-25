function pop = fill(pop, varargin)

% population/fill
%
% pop = nextMut(pop, value=0)
%
% Fills the population with value.

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnólogico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

if length(varargin) >= 1
   value = varargin{1};
else 
   value = 0;
end

k = length(pop.individual(1).r);
pat = ones(1,k)*value;
for i=1:length(pop.individual)
   pop.individual(i).r = pat;
end
