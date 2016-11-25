function value = basemax(x,varargin)
%
% zeromax(x,B=2)
%
% Implements the function basemax(x(1),B) + basemax(x(2),B) + ...
% where basemax returns the number of digits base B of x equal to B-1.
%
% See also: onemax, zeromax

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
  B = varargin{1};
else
  B = 2;
end  

value = 0;
for i=1:length(x)
  value = value + basemaxScalar(x(i),B);
end

function res = basemaxScalar(x,B)
y = dec2base(x,B,B);
res = sum(y == num2str(B-1));
