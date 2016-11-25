function pop = uniformCrossover(pop,p0,varargin)

% population/uniformCrossover
%
% pop = uniformCrossover(pop,p0,lastTwo=0)
%
% Applies uniform crossover to members of a population. The flag lastTwo is
% used to implement a steady state algorithm; uniform crossover is applied 
% only two the last two individuals in the population.
%
% Currently, only works for integers and traditional digits.
%
% DON'T USE, DOES NOT WORK

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


CROSSOVER_TEST = 1; % cross individuals in consecutive positions

   
if length(varargin)>=1
   lastTwo = varargin{1};
else
   lastTwo = 0;
end
   
if mod(length(pop.individual),2) ~= 0 
   error('Population size must be even for crossover')
end

fLen = length(pop.individual(1).fitness);

type   = pop.params.type;
dist   = pop.params.dist;
digits = pop.params.digits;
m      = pop.params.m;
B      = pop.params.B;
N      = pop.params.N;

if  ~isequal(digits,'traditional')
   error(stract('Cannot perform uniform crossover for ',digits,' digits'));
end

if  ~isequal(type,'integer')
   error(stract('Cannot perform uniform crossover for ',type,' digits'));
end

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

h1 = zeros(1,m); % preallocation for speed
h2 = zeros(1,m); % preallocation for speed

for i=start:2:length(pop.individual)
   
   if rand <= pop.params.pc % perform crossover
      % identify individuals to be crossed over
      pop.trace.nCross = pop.trace.nCross + 1;
      i1 = index(i);
      i2 = index(i+1);
      
      % Crossover individuals i1 and i2
      r1 = pop.individual(i1).r;
      r2 = pop.individual(i2).r;
      for j=1:m
         template = rand(1,N(j))>p0;
         [h1(j) h2(j)] = crossAtUniform(r1(j),r2(j),template,B(j));
      end
      pop.individual(i1).r = h1;
      pop.individual(i2).r = h2;
      
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

