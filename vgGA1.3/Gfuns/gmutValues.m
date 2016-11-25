function res = gmutValues(p, n, delta)

% gmutValues(p, n, delta)
%
% Returns a vector of all the possible results of the
% mutation of p starting at value n and with width delta.
  
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

  ran = [0:1:delta-1];
  res = ones(size(ran))*(glow(p,n)+ghigh(p,n*delta)) + n*ran;
