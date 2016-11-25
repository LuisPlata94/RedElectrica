function res = interDeceptive(x,m)

% interDeceptive(x,m)
%
% Implementa una funcion formada por m problemas completamente 
% engañosos de n bits, donde los bits estan intercalados.  
%
% Recibe un vector x de n elementos donde x(1) son los bit 1
% de los m problemas, x(2) son los bit 2, etc. Regresa la 
% evaluacion de cada uno de los m problemas.

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

n = length(x);
unos = sum(dec2bin(x,m)=='1',1)';
res = (unos<n).*(2*(n-1-unos)) + (unos>=n).*(2*n-1);

