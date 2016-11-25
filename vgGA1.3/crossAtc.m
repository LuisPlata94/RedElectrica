function [h1,h2] = crossAtc(r1,r2,k,rMax,varargin)

% [h1,h2] = crossAtc(r1, r2, k, rMax, rMin=0)
%
% Performs crossover of r1 and r2 at value k. The numbers 
% r1 and r2 take a minimal value or rMin. Notice that 
% h1 + h2 = r1 + r2. Works for integers and reals.
% It applies the crossover correction needed for generalized
% and continuous digits.
%
% See also: crossAt, crossAtUniform

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

r = sort([r1 r2]);
r1 = r(2);
r2 = r(1);

chi = mod(r1-rMin,k-rMin) - mod(r2-rMin,k-rMin);
h1 = r2 + chi;
h2 = r1 - chi;
if h2>=rMax
   % h2 = rMax;             % Crossover correction 1 
   h2 = rMax - h1 + rMin;   % Crossover correction 2
end   
