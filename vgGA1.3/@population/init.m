function pop = init(pop)

% population/init
%
%  pop = init(pop)
%
%  Erases all the individuals and resets best.

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

% Start best found
if isequal(pop.params.type,'real')
   pop.best.r = pop.params.rMin;
elseif isequal(pop.params.type,'integer')
   pop.best.r = zeros(1,pop.params.m);
end

if pop.params.max == 1
   pop.best.fitness = -Inf;
else
   pop.best.fitness = Inf;
end
pop.best.evals = 0;
pop.evals = 0;

% Start empty population
pop.individual = [];

% Start empty mutation clock
pop.mutclock = [];

% Start empty tracing structure
pop.trace.nMuts = 0;
pop.trace.nCross = 0;
pop.trace.nIPC = 0;

% Start empty inheretance control
pop.params.inheritance = 0;
pop.params.error = NaN;

% Start mutation clock
pop = startMut(pop);
if pop.params.pm > 0
   for i=1:pop.params.m
      pop = nextMut(pop,i);
  end
end
