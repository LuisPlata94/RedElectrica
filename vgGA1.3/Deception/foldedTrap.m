function res = foldedTrap(x,n,varargin)

%    f(x)
%      ^ 
%      |
%    1 X                                                   X
%      |X                                                 X 
%    a + X    -   -   -   -   -  X                       X .
%      |  X                   X     X                   X   
%      |   X               X     .     X               X   .
%      |    X           X                 X           X     
%      |     X       X           .           X       X     .
%      |      X   X                             X   X       
%      +-------X-----------------+-----------------X-------+--->  no. de
%      0       1                n/2               n-1      n       unos
%
%      +-------+-----------------+-----------------+-------+---> cromosoma
%   00...0  10...0                              01...1  11...1    binario
%           01...0                              10...1
%              :                                   :
%           00...1                              11...1
%
% donde
%
%          n/2 - 1
%     a = ---------
%           n - 3
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

% Se toman los argumentos si existen y son validos
if length(varargin)>= 1 
   k = varargin{1};
else
   k = 1;
end
if length(k)~=length(x)
   k = 1;
end

if length(n) ~= length(x)
   n = n(1)*ones(1,length(x));
end

a = (n/2-1)./(n-3);
unos = sum(dec2bin(x,max(n))=='1',2)';
unos = (unos<=n/2).*unos + (unos>n/2).*abs(unos-n);
res = sum( k.*( (unos<1) + (unos>=1).*(2*a.*(unos-1)./(n-2)) ) );
