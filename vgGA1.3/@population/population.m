function pop = population(type,varargin)
% population/population Class constructor
%
% pop = population('i(nteger)',N,pm,pc,B,delta,dist,digits)
% pop = population('r(eal)',R,N,pm,pc,B,delta,dist,digits)
%
% Constructs a population of a given type ('integer' or 'real'). 
% Parameters:
%
% R:      mx2 matrix of min and max values of segments
% N:      mx1 vector of the number of digits per segment
%         (for type 'real', default = Inf)
% pm:     mutation probability (default = 0.0)
% pc:     crossover probability (default = 1.0)
% B:      base (default = 2)
% delta:  mutation delta (default = B)
% dist:   distribution of crossover and mutation points,
%         'u(niform)', 'e(xponential)' (default)
% digits: 'c(ontinuous)', 'g(eneralized)' or 't(raditional)'(default)

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

MAXIMIZATION = 1; % Default of params.max

NO_FUNCTIONS = 1; % Initial value of params.noFunctions
 
pop.params.max = MAXIMIZATION;

pop.params.noFunctions = NO_FUNCTIONS;

% Display parameters
pop.params.dBest = 1;
pop.params.dChroms = 1;
pop.params.dPhenos = 1;
pop.params.dParams = 1; 

if isequal(type,'r') || isequal(type,'R')
   type = 'real';
elseif isequal(type,'i') || isequal(type,'I')
   type = 'integer';
end


if isequal(type,'real') || isequal(type,'integer') 
   pop.params.type = type;
else
   error(strcat(type,' is not a valid type of population'))
end

% Defaults
pop.params.pm = 0;
pop.params.pc = 1;
pop.params.B = 2;
pop.params.delta = pop.params.B;
pop.params.dist = 'exponential';
pop.params.digits = 'traditional';

if isequal(type,'real')
   R = varargin{1};
   m = size(R);
   pop.params.m = m(1);
   pop.params.rMin = R(:,1)';
   pop.params.rMax = R(:,2)';
   pop.params.DeltaR = (R(:,2) - R(:,1))';
   pop.params.N = ones(1,length(R))*Inf;
   if length(varargin)>=2
      pop.params.N = varargin{2};
   end
   if length(pop.params.N)~=pop.params.m
      pop.params.N = ones(1,pop.params.m)*pop.params.N(1);
   end
   %pop.params.rMax = rMax(R(:,1)',R(:,2)',pop.params.N,pop.params.B);
   pop.best.r = R(:,1)';
   varargin = varargin(2:length(varargin));
elseif isequal(type,'integer')
   N = varargin{1};
   m = length(N);
   pop.params.m = m;
   pop.params.N = N;
   pop.best.r = zeros(1,pop.params.m);
   pop.params.rMin = zeros(1,pop.params.m);
   pop.params.rMax = pop.params.B.^pop.params.N;
   por.params.DeltaR = pop.params.rMax;
end


if length(varargin)>=2
   pop.params.pm = varargin{2};
end
if length(varargin)>=3
   pop.params.pc = varargin{3};
end
if length(varargin)>=4
   pop.params.B = varargin{4};
   pop.params.delta = pop.params.B;
end
if length(varargin)>=5
   pop.params.delta = varargin{5};
end
if length(varargin)>=6
   dist = varargin{6};
   if isequal(dist,'e') || isequal(dist,'E')
      dist = 'exponential';
   elseif isequal(dist,'u') || isequal(dist,'U')
      dist = 'uniform';
   end
   pop.params.dist = dist;
end
if length(varargin)>=7
   digits = varargin{7};
   if isequal(digits,'t') || isequal(digits,'T')
      digits = 'traditional';
   elseif isequal(digits,'g') || isequal(digits,'G')
      digits = 'generalized';
   elseif isequal(digits,'c') || isequal(digits,'C')
      digits = 'continuous';
   end
   pop.params.digits = digits;
end







if isequal(pop.params.digits,'continuous') && ~isequal(pop.params.dist,'uniform')
   error('continuous digits can only be used with uniform distribution')
end
if sum(pop.params.N==Inf)>0 && ~isequal(pop.params.digits,'continuous')
   fprintf('Infinite number of digits can only be used with continuous\n')
   fprintf('digits and uniform distribution.  Will set as required.\n')
   pop.params.dist = 'uniform';
   pop.params.digits = 'continuous';
end

if length(pop.params.B)~=pop.params.m
   pop.params.B = ones(1,pop.params.m)*pop.params.B(1);
end
if length(pop.params.pm)~=pop.params.m
   pop.params.pm = ones(1,pop.params.m)*pop.params.pm(1);
end
if length(pop.params.delta)~=pop.params.m
   pop.params.delta = ones(1,pop.params.m)*pop.params.delta(1);
end
if sum(pop.params.B.^pop.params.N > 2^52) && sum(pop.params.N==Inf)==0
   warning('***** WARNING: POSSIBLE ROUNDING ERRORS *****')
   for i=1:m
      if pop.params.B(i)^pop.params.N(i) > 2^52
         fprintf('***** Segment %i:  %3d is too long for base %d;',i,pop.params.N(i),pop.params.B(i))
         fprintf(' max digits for this base is %d\n',floor(logB(2^52,pop.params.B(i))))
      end
   end   
   cont = input('***** Do you want to continue? (Y/N) ','s');
   if not(strcmp(cont,'Y')|strcmp(cont,'y'))
      clear pop
      return
   end
end


% Start best found
if pop.params.max == 1
   pop.best.fitness = -Inf(1,pop.params.noFunctions);
else
   pop.best.fitness = Inf(1,pop.params.noFunctions);
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

pop = class(pop, 'population');

% Start mutation clock
pop = startMut(pop);
if pop.params.pm > 0
   for i=1:pop.params.m
      pop = nextMut(pop,i);
  end
end

