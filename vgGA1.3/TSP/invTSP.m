function [v,n1,n2] = invTSP(permutation)

% [v,n1,n2] = invTSP(permutation)
%
% Produces a random inversion v of a permutation. Returns the to poins n1 
% and n2 at which the inversion was performed.
%
% See also: tableTSP, fcnTSP, plotTSP

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

n = length(permutation);
% Find two random positions to perform an inversion
m1 = floor(rand*n)+1;
m2 = mod(floor(rand*(n-1))+m1, n)+1;
n1 = min([m1 m2]);
n2 = max([m1 m2]);

% Performs inversion from postion n1 to position n2
v = permutation;
v(n1:n2) = permutation(n2:-1:n1);
