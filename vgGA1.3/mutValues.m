function values = mutValues(r,k,delta,varargin)

% mutValues(r, k, delta, rMin=0)
%
% Returns a vector of all the possible results of the 
% mutation of r at value k. The number r takes a minimal 
% value of rMin (default = 0). Works for integers and 
% reals. (This function is used only for testing.)
%
% See also: mutate
  
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

if length(varargin)>=1
   rMin = varargin{1};
else
   rMin = 0;
end

sum1 = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin);
sum2 = (k - rMin)*[0:delta-1];
values = sum1 + sum2;











