function value = mutateGen(r,k,delta,rMax,varargin)

% mutateGen(r, k, delta, rMax, rMin=0)
%
% Returns the mutation of r at value k which is a generalized
% digit value. This function implements the gamma correction. 

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
sum = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin) - rMin;
if k-rMin > 0  % to avoid possible division by zero
  gamma = (rMax-sum)/(k-rMin);
else
  gamma = delta;
end
if gamma > delta % gamma cannot be greater than delta
  gamma = delta; 
end
value = sum + (k-rMin)*floor(rand*gamma);
if value<0
   fprintf('***> [%5.0f,%5.0f) r=%8.0f k=%8.0f delta=%8.0f gamma=%8.0f sum=%8.0f value=%9.2f <***\n',value,rMin,rMax,r,k,delta,gamma,sum)
   pause
end
