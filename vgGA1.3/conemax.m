function value = conemax(x,varargin)

% conemax(x,B=2)
% 
% Implements the consecutive one max function
%
% See also: onemax, zeromax, basemax

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

global alpha
alpha = 2;

% if length(varargin)>=1
%   B = varargin{1};
% else
%   B = 2;
% end  
  
B  = 2;

value = 0;
for i=1:length(x)
  value = value + conemaxScalar(x(i),B);
end

  

function res = conemaxScalar(x,B)
global alpha
y = dec2base(x,B);
icons = 0;
res = 0;
i = 0;
while i < length(y)
  i = i + 1;
  if y(i) == '1'
    icons = icons + 1;
  else
    res = res + icons^alpha;
    icons = 0;
  end
end
if icons ~= 0
  res = res + icons^alpha;
end


