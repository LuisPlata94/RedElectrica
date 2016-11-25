function [h1, h2] = pmx(p1, p2, varargin)

% [h1,h2] = pmx(p1, p2)
% [h1,h2] = pmx(p1, p2, crosspoint1, crosspoint2)
%
% Implements Partial Mapped Crossover (PMX) of permutations 
% p1 and p2. Crossover points are generated randomly if not
% given. crosspoint1 must be less than crosspoint2. 
% 
% See also:  cx, erx, ox 

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

if length(varargin) >= 2
  % if given, accept crosspoints
  c1 = varargin{1};
  c2 = varargin{2};
else
  % if not given, generate crosspoints
  c1 = floor(rand*(length(p1)-1))+1;
  c2 = floor(rand*(length(p2)-1));
  if c2 >= c1
    c2 = c2 + 1;
  else
    tmp = c1;
    c1 = c2;
    c2 = tmp;
  end
end

if c2 <= c1
  error('crossover points are incorrect (c2<=c1)')
end

h1 = p1;  % child1
h2 = p2;  % child2

for i=c1+1:c2
  j = find(h2==p1(i));
  tmp = h2(j);
  h2(j) = h2(i);
  h2(i) = tmp;
  j = find(h1==p2(i));
  tmp = h1(j);
  h1(j) = h1(i);
  h1(i) = tmp;
end




