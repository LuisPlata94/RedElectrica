function value = onemax(x,varargin)
%
% onemax(x,B=2)
%
% Implements the function onemax(x(1),B) + onemax(x(2),B) + ...

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
  value = value + onemaxScalar(x(i),B);
end

  

function res = onemaxScalar(x,B)
y = dec2base(x,B);
res = sum(y == '1');
