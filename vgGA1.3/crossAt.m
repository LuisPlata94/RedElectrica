function [h1,h2] = crossAt(r1,r2,k,varargin)

% [h1,h2] = crossAt(r1, r2, k, rMin=0)
%
% Performs crossover of r1 and r2 at value k. The numbers 
% r1 and r2 take a minimal value or rMin.
% Notice that h1 + h2 = r1 + r2. Works for integers and
% reals.
%
% See also: crossAtc

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

chi = mod(r1-rMin,k-rMin) - mod(r2-rMin,k-rMin);
h1 = r2 + chi;
h2 = r1 - chi;

