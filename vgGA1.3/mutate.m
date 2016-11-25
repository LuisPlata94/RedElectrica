function value = mutate(r,k,delta,varargin)

% mutate(r, k, delta, rMin=0)
%
% Returns the mutation of r at value k. The number r 
% takes a minimal value of rMin (default = 0). Works for 
% integers and reals.
% 
% See also: mutateGen

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
sum2 = (k - rMin)*floor(rand*delta);
value = sum1 + sum2;
% fprintf('low=%d high=%d\n',low(r,k,rMin),high(r,(k-rMin)*delta+rMin,rMin))
% fprintf('sum1=%d sum2=%d\n',sum1,sum2)
% fprintf('r=%d k=%d delta=%d value=%d\n',r,k,delta,value)
% pause

