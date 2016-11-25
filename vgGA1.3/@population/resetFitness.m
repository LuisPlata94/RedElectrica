function pop = resetFitness(pop,varargin)

% population/resetFitness
%
% pop = resetFitness(pop,fitLen=noFunctions)
%
% Resets the fitness vector of all individuals to the first fitLen
% components.
%
% See also population/startFitness

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
   fitLen = varargin{1};
else
   fitLen = pop.params.noFunctions;
end

for i=1:length(pop.individual)
   pop.individual(i).fitness = pop.individual(i).fitness(1:fitLen);
end
