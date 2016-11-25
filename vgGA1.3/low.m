function res = low(r, k, varargin)
% low(r, k, rMin=0)
% 
% Low part of number r up to value k. The number r
% takes a minimal value of rMin. Notice that  
% r = low(r,k,rMin) + high(r,k,rMin).  This works
% both for integers and reals.
%
% Example:
%
%   a = [2 1 2 0 0]*(3.^[0 1 2 3 4]')
%
%   a =
%
%      23   
%
%   low(23,3.^[0 1 2 3 4]) =
%
%      0   2   5  23  23
%
% See also: high, highh.

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
   rMin = varargin{1};
else
   rMin = 0;
end
res = mod(r-rMin,k-rMin) + rMin;
