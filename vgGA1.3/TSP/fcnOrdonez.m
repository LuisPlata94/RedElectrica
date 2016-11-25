function f = fcnOrdonez(chromosome)

% f = fcnOrdonez(chromosome)
% Evaluates a chromosome that represents a permutation using Ordóñez idea.
% The chromosome is decodes using function ordonez, and evaluated using
% fcnTSP.
%
% See also: fcnTSP, ordonez

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

permutation = ordonez(chromosome);
f = fcnTSP(permutation);

