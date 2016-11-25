function res = spike(x,n,varargin)

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

% Se toman los argumentos si existen y son validos
if length(varargin)>= 1 
   k = varargin{1};
else
   k = 1;
end
if length(k)~=length(x)
   k = 1;
end

res = sum(k.*(x==2.^n-1));

