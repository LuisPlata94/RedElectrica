function res = generalized(m,varargin)
  
% generalized(m,B=2)
% 
% Truncates a number m to generalized digits.

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

B = 2;
if length(varargin) >= 1
  B = varargin{1};
end

Bm = B.^m;

if sum(Bm == Inf) > 0
   res = m;
else
   res = logB(floor(Bm),B);
end

