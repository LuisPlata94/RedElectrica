function value = testScale(x)

% exp(-x/10)*sin(x)+20 or exp(-x/10)*sin(x)
%
% This function is used to demonstrate the need for fitness scaling.

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

T = 1;

if T
   value = exp(-x(1)/10).*sin(x(1))+20;
else
   value = exp(-x(1)/10).*sin(x(1));
end
