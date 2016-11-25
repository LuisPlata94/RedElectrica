function res = high(r, k, varargin)
% high(r, k, rMin=0)
%
% High part of number r starting with value k. The number 
% r takes a minimal value of rMin. Notice that 
% r = low(r,k,rMin) + high(r,k,rMin). This function works 
% for integers and reals.
%
% Example:
%
%   a = [2 1 2 0 0]*(3.^[0 1 2 3 4]')
%
%   a =
%
%      23   
%
%   high(23,3.^[0 1 2 3 4]) =
%
%      23  21  18   0   0
%
% See also: low, highh.

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
res = r - mod(r-rMin,k-rMin) - rMin;  
