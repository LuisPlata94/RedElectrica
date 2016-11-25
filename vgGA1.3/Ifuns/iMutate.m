function value = iMutate(r,k,delta,varargin)

% imutate(r, k, delta, B=2, rMin=0)
%
% Returns the imutation of r at value k. The number r 
% takes a minimal value of rMin. Works for integers and reals.

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

if nargin >= 1
  B = varargin{1};
else
  B = 2;
end
if nargin >= 2
   rMin = varargin{2};
else
   rMin = 0;
end

sum1 = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin);
seg = (r - rMin - sum1)/k;
sum2 = (k-rMin)*mod(seg*floor(rand(1,1)*delta),B);
value = sum1 + sum2;
