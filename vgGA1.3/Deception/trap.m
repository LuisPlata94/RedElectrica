function res = trap(x,n,varargin)

% trap(x,n,k=1,z=n-1,b=1,a=valor min para tener engaño) DGA
%
% Implementa una funcion trap de n bits.
% x y n deben ser vectores renglon
%
%
%    f(x)
%      ^ 
%      |
%    b +  -   -   -   -   -   -  X
%      |                        X
%    a X                       X .
%      |  X                   X
%      |     X               X   .
%      |        X           X
%      |           X       X     .
%      |              X   X
%      +-----------------X-------+--->  no. de
%      0                 z       n       unos
%
%      +-----------------+-------+---> cromosoma
%   00...0                    11...1    binario
%
%
% Se debe cumplir que 
%
%                     1
%              2 - -------
%       a           n - z
%      --- >= --------------
%       b             1
%                2 - ---
%                     z
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

if length(n) ~= length(x)
   n = n(1)*ones(1,length(x));
end

% Defaults de k, z, y b
k = 1;   % sin pesos
z = n-1; % maxima dificultad
b = 1;   % normalizado a 1

% Se toman los argumentos si existen y son validos
if length(varargin)>= 1 
   k = varargin{1};
end
if length(k)~=length(x)
   k = 1;
end

if length(varargin)>=2
   z = varargin{2};
end
if length(z)~=length(x)
   z = n-1;
end

if length(varargin)>=3
   b = varargin{3};
end
if length(b) ~= length(x) 
   b = 1;
end   

% Default de a
a = b.*((2-1./(n-z))./(2-1./z));
% Se toma el argumento si existe y es valido
if length(varargin)>=4
   a = varargin{4};
end
if length(a) ~= length(x) 
   a = b.*((2-1./(n-z))./(2-1./z));
end   

% Se checa la condicion de engaño
if sum( a./b < ((2-1./(n-z))./(2-1./z)) ) > 0
   error('no se cumple condicion de a/b')
end


unos = sum(dec2bin(x,max(n))=='1',2)';
res = sum( k.*( (unos<z).*a.*(1-unos./z) + (unos>=z).*b.*(unos-z)./(n-z) ) );
