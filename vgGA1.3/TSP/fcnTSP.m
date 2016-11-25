function f = fcnTSP(varargin)

% fcnTSP(distance)
% Loads a distance (cost) matrix.
%
% f = fcnTSP(permutation)
% Evaluates a permutation using a distance matrix that has been previously 
% loaded. 
%
% fcnTSP
% Erases the distance matrix.
%
% See also: invTSP, tableTSP, plotTSP

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

persistent distance


if isempty(varargin)
   clear distance
else
   [n,m] = size(varargin{1});
   if n==m
      % Initialize distance matrix
      distance = varargin{1};
   else
      permutation = varargin{1} + 1;
      n = length(permutation);
      % Start with distance between last a first city of the permutation.
      f = distance(permutation(n), permutation(1));
      for i=2:n
         % Add distance from city i-1 to city i
         f = f + distance(permutation(i-1), permutation(i));
      end
   end
end
