function res = digit(p,n,B)
% digit(p,n,B)
%
% Digit of weight n/B, base B, of number p. Works only
% for integers.
%
% Examples:
%
%    digit(7,[2 4 8 16],2) =
% 
%        1  1  1  0
%
%    digit(2*3^0+1*3^1+2*3^3,3.^[1 2 3 4],3) =
% 
%        2  1  2  0
%
% See also: segment.

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

res = low(highh(p,n./B),B);
