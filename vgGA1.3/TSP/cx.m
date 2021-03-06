function [h1, h2] = cx(p1, p2)

% [h1,h2] = cx(p1, p2)
%
% Implements Cyclic Crossover (CX) of permutations 
% p1 and p2.
% 
% See also:  erx, ox, pmx

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rend�n                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnol�gico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

n = length(p1);
h1 = p2;
h2 = p1;
j = 1;
while 1 
  h1(j) = p1(j);
  j = find(p1==p2(j));
  if j == 1
    break
  end
end
j = 1;
while 1 
  h2(j) = p2(j);
  j = find(p2==p1(j));
  if j == 1
    break
  end
end

