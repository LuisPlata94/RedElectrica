function res = Sh(d,sigma,varargin)

% Sh(d,sigma,alpha=1)
%
% Implements Deb's sharing function

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Departamento de Mecatrónica y Automatización           *
%*   Tecnológico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

if length(varargin)>=1
   alpha = varargin{1};
else
   alpha = 1;
end
res = (d<=0) + (d>0).*(d<sigma).*(1-(d/sigma).^alpha);
