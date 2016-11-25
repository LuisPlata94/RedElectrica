function res = convert(digit,delta)
% convert(digit,delta)
%
% Converts a vector of digits and a vector of deltas
% into a number.  Both digit and delta must be integers.
%
% See also: digit.

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

n = length(delta);
factor = 1;
res = 0;
for i=1:n,
   res = res + factor*digit(i);
   factor = factor*delta(i);
end

   
