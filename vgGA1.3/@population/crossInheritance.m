function pop = crossInheritance(pop)
% population/crossInheritance
%
% pop = crossInheritance(pop)
%
% Applies crossover with inheritance to members of a population.
% USE WITH CAUTION: UNDER CONSTRUCTION

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

if mod(length(pop.individual),2) ~= 0 
   error('Population size must be even for crossover')
end

type = pop.params.type;
dist = pop.params.dist;

index = randperm(length(pop.individual));
% index = [1:length(pop.individual)]; %use this for testing

for i=1:2:length(pop.individual)

  % digits might change due to non-overflow crossover correction
  digits = pop.params.digits;

  if rand <= pop.params.pc % perform crossover
    % identify individuals to be crossed over
    pop.trace.nCross = pop.trace.nCross + 1;
    i1 = index(i);
    i2 = index(i+1);

    % Keep parents
    parent1 = pop.individual(i1);
    parent2 = pop.individual(i2);
    
    % Crossover individuals i1 and i2
    r1 = pop.individual(i1).r;
    r2 = pop.individual(i2).r;

    % choose segment for cross site
    %I (this could be changed to make probability proportional to
    %I number of bits per segment)
    j = ceil(rand*pop.params.m);

    % exchange segments before cross site
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
       % digits is changed only for this segment
       digits = 'traditional';
    end

    % crossover segment j
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

    % erase fitness and inherit estimated fitness if offspring are 
    % different than parents
    if pop.params.weighted
       weight = (j/pop.params.m)*((k-pop.params.rMin(j))/pop.params.DeltaR(j));
    else
       weight = 0.5;
    end
    if ~isequal(r1,pop.individual(i1).r)
       pop.individual(i1).fTrue = NaN;
       pop.individual(i1).fEsti =  ...
          parent1.fitness*weight + parent2.fitness*(1-weight);
       pop.individual(i1).fitness = pop.individual(i1).fEsti;
       pop.individual(i1).iCtrl = ...
          pop.params.beta*(parent1.iCtrl*weight + parent2.iCtrl*(1-weight));
    end
    if ~isequal(r2,pop.individual(i2).r)
       pop.individual(i2).fTrue = NaN;
       pop.individual(i2).fEsti =  ...
          parent1.fitness*(1-weight) + parent2.fitness*weight;
       pop.individual(i2).fitness = pop.individual(i2).fEsti;
       pop.individual(i2).iCtrl = ...
          pop.params.beta*(parent1.iCtrl*(1-weight) + parent2.iCtrl*weight);
    end
  end % if crossover

end % for

for i=1:length(pop.individual)
   pop.individual(i).fitness = pop.individual(i).fitness(1);
end



