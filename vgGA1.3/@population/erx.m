function pop = erx(pop,varargin)

% POPULATION/CROSSOVER
%
% pop = crossover(pop,lastTwo=0)
%
% Applies ERX crossover to members of a population. The flag lastTwo is
% used to implement a steady state algorithm; if set, crossover is applied 
% only to the last two individuals in the population.
%

% M. Valenzuela
% mar 2009
%
%*****************************************************************
%*                                                               *
%*   vgGA: The Virtual Gene Genetic Algorithm                    *
%*                                                               *
%*   Copyright (c) 2001-2009 All Rights Reserved                 *
%*                                                               *
%*   Manuel Valenzuela-Rendón                                    *
%*   valenzuela@itesm.mx                                         *
%*   http://homepages.mty.itesm.mx/valenzuela                    *
%*                                                               *
%*   Tecnológico de Monterrey, Campus Monterrey                  *
%*   Monterrey, N.L., Mexico                                     *
%*                                                               *
%*****************************************************************

CROSSOVER_TEST = 0;

if length(varargin)>=1
   lastTwo = varargin{1};
else
   lastTwo = 0;
end
   
% if mod(length(pop.individual),2) ~= 0 
%   error('Population size must be even for crossover')
% end

fLen = length(pop.individual(1).fitness);

type = pop.params.type;

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

% each pair of individuals produce two offsprings. Perhaps, individual i
% should cross with j, j with k, etc, so that each individual crosses with
% two different individuals.

for i=start:2:length(pop.individual)

  if rand <= pop.params.pc % perform crossover
    % identify individuals to be crossed over
    pop.trace.nCross = pop.trace.nCross + 1;
    i1 = index(i);
    i2 = index(i+1);

    % Crossover individuals i1 and i2
    r1 = pop.individual(i1).r;
    r2 = pop.individual(i2).r;

    % exit if type is incorrect
    %I this check is probably unnecessary
    if not ( isequal(type, 'integer') )
       error(strcat('cannot perform ERX crossover over type ', type));
    end

    pop.individual(i1).r = erx_original(r1+1,r2+1)-1;
    if ~lastTwo
       pop.individual(i2).r = erx_original(r1+1,r2+1)-1;
    end
    
    % erase fitnesses if offspring are different than parents
    if ~isequal(r1,pop.individual(i1).r)
       pop.individual(i1).fitness = ones(1,fLen)*NaN;
    end
    if ~isequal(r2,pop.individual(i2).r) && ~lastTwo
       pop.individual(i2).fitness = ones(1,fLen)*NaN;
    end
    
  end % if crossover

end % for


