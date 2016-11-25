function pop = crossover(pop,varargin)

% population/crossover
%
% pop = crossover(pop,lastTwo=0)
%
% Applies crossover to members of a population. The flag lastTwo is
% used to implement a steady state algorithm; crossover is applied only
% two the last two individuals in the population.
%

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

CROSSOVER_TEST = 0; % cross individuals in consecutive positions

if length(varargin)>=1
   lastTwo = varargin{1};
else
   lastTwo = 0;
end
   
if mod(length(pop.individual),2) ~= 0 
   error('Population size must be even for crossover')
end

fLen = length(pop.individual(1).fitness);

type = pop.params.type;
dist = pop.params.dist;

if lastTwo || CROSSOVER_TEST 
   index = 1:length(pop.individual); %use this for testing
else
   index = randperm(length(pop.individual));
end

if lastTwo
   start = length(pop.individual)-1;
else
   start = 1;
end

for i=start:2:length(pop.individual)

  % digits might change due to non-overflow crossover correction
  digits = pop.params.digits;

  if rand <= pop.params.pc % perform crossover
    % identify individuals to be crossed over
    pop.trace.nCross = pop.trace.nCross + 1;
    i1 = index(i);
    i2 = index(i+1);

    % Crossover individuals i1 and i2
    r1 = pop.individual(i1).r;
    r2 = pop.individual(i2).r;

    % choose parameter for cross site
    %I (this could be changed to make probability proportional to
    %I number of bits per parameter)
    j = ceil(rand*pop.params.m);

    % exchange parameters before cross site
    tmp = pop.individual(i1).r(1:j-1);
    pop.individual(i1).r(1:j-1) = pop.individual(i2).r(1:j-1);
    pop.individual(i2).r(1:j-1) = tmp;

    % exit if type is incorrect
    %I this check is probably unnecessary
    if not ( isequal(type, 'real') | isequal(type, 'integer') )
       error(strcat('cannot perform crossover over type ', type));
    end

    % perform the non-overflow crossover correction for
    % continuous or generalized digits
    if (isequal(digits,'continuous') || isequal(digits,'generalized')) && ...
          ( (pop.individual(i1).r(j)+pop.individual(i2).r(j) -...
          pop.params.rMin(j)) >= pop.params.rMax(j) )
       % digits is changed only for this parameter
       digits = 'traditional';
    end

    % crossover parameter j
    if isequal(type,'integer')
       k = crossPoint(type, digits, dist, pop.params.N(j), pop.params.B(j));
       [pop.individual(i1).r(j) pop.individual(i2).r(j)] = ...
          crossAt(pop.individual(i1).r(j),pop.individual(i2).r(j), k);
    elseif isequal(type,'real') && (pop.params.N(j)==Inf) && ...
          isequal(digits,'traditional')
       % You are here because of the non-overflow crossover
       % correction, and I haven't found a way to treat N==Inf, so
       % I'll just do nothing, and count this as an iterparameter crossover
       pop.trace.nIPC = pop.trace.nIPC + 1;

    elseif isequal(type,'real')
       k = crossPoint(type, digits, dist, pop.params.N(j), pop.params.B(j),...
          pop.params.rMin(j), pop.params.rMax(j));
       [pop.individual(i1).r(j) pop.individual(i2).r(j)] = ...
          crossAt(pop.individual(i1).r(j),pop.individual(i2).r(j),k,...
          pop.params.rMin(j));
    end


    % erase fitnesses if offspring are different than parents
    if ~isequal(r1,pop.individual(i1).r)
       pop.individual(i1).fitness = ones(1,fLen)*NaN;
    end
    if ~isequal(r2,pop.individual(i2).r)
       pop.individual(i2).fitness = ones(1,fLen)*NaN;
    end
    
  end % if crossover

end % for

if lastTwo
   % keep only first offspring
   pop.individual = pop.individual(1:length(pop.individual)-1);
end

