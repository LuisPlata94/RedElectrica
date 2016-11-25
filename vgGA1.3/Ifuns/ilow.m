function res = ilow(p, m, varargin)

% ilow(p, m, B=2) = L_m(p)
%
% Low part of integer p up to digit m of base B.
 
%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rend�n                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnol�gico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

  if length(varargin)>=1
    B = varargin{1};
  else
    B = 2;
  end
  
  res = mod(p,B.^m);

