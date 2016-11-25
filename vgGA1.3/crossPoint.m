function k = crossPoint(varargin)

% k = crossPoint(type, digits, dist, N, B, rMin, rMax)
%
% Returns the crossover point for a vgGA. 
% Parameters:
%
% type:   'integer' (default) or 'real'  
% digits: 'continuous', 'generalized', or 'traditional'(default)
% dist:   distribution of crossover point,
%         'uniform' or 'exponential' (default)
% N:      number of digits (default = Inf)
% B:      base (default = 2)
% rMin:   minimum value (default = 0)
% rMin:   maximum value (default = B^N)

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

global type digits dist
  
type = 'integer';
digits = 'traditional';
dist = 'exponential';
N = Inf;
B = 2;
rMin = 0;

if nargin >= 1
  type = varargin{1};
end
if nargin >= 2
  digits = varargin{2};
end
if nargin >= 3
  dist = varargin{3};
end
if nargin >= 4
  N = varargin{4};
end
if nargin >= 5
 B = varargin{5};
end
if nargin >= 6
  rMin = varargin{6};
end
if nargin >= 7
  rMax = varargin{7};
else
  rMax = B^N;
end

% Crossover for integers
if equal('integer', 'traditional', 'exponential') & (N~=Inf)
  k = B^floor(N*rand);
elseif equal('integer', 'generalized', 'exponential') & (N~=Inf)
  k = floor(B^(N*rand));
elseif equal('integer','traditional','uniform') & (N~=Inf)
  % k = traditional((B^N-1)*rand,B);
  k = B.^(floor(logB(ceil((B^N-1)*rand),B)));
elseif equal('integer', 'generalized', 'uniform') & (N~=Inf)
  k = ceil((B^N-1)*rand);

% Crossover for reals
elseif equal('real', 'traditional', 'exponential') & (N~=Inf)
  k = B^floor(N*rand)*(rMax-rMin)/B^N + rMin;
elseif equal('real','generalized','exponential') & (N~=Inf)
  k = floor(B^(N*rand)) * (rMax-rMin)/B^N + rMin;
elseif equal('real','continuous','exponential') & (N~=Inf)
  k = B^(N*rand) * (rMax-rMin)/B^N + rMin;
elseif equal('real','traditional','uniform') & (N~=Inf)
  % k = traditionalvalue((B^N-1)*rand,B) * (rMax-rMin)/B^N + rMin;
  k = B.^(floor(logB(ceil((B^N-1)*rand),B))) * ...
     (rMax-rMin)/B^N + rMin;
elseif equal('real','generalized','uniform') & (N~=Inf)
  k = ceil((B^N-1)*rand) * (rMax-rMin)/B^N;
elseif equal('real','continuous','uniform') & (N~=Inf)
  k = ((rMax-rMin)/B^N)*(rand*(B^N-1)+1) + rMin;
elseif equal('real','continuous','uniform') & (N==Inf)
  k = rand*(rMax-rMin) + rMin;
  
else
  error(['crossover for ',type, ' ', dist, ' ', digits,... 
	 ' and N=', num2str(N), ', not implemented']);
end

function v = equal(typ, dig, dis)
  global type digits dist
  v = isequal(typ,type) & isequal(dis,dist) & isequal(dig,digits);







