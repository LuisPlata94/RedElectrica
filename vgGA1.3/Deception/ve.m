function res = ve(x,n,varargin)
%
%
%    f(x)
%      ^ 
%      |
%    1 X  -  -  -  -  -  -  -  -  -  -  -  X
%      |  X                             X
%      |     X                       X     .
%      |        X                 X
%      |           X           X           .
%      |              X     X
%      +-----------------X-----------------+--->  no. de
%      0                n/2                n       unos
%
%      +-----------------+-----------------+---> cromosoma
%   00...0            00...11           11...1    binario
%

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


if length(varargin)>= 1 
   k = varargin{1};
else
   k = 1;
end
if length(k)~=length(x)
   k = 1;
end

unos = sum(dec2bin(x,max(n))=='1',2)';

frac = x - floor(x);

n2 = n/2;

res = sum( k.*((n2-unos).*(unos<n2) + (unos-n2).*(unos>n2) + frac)./n2 );
