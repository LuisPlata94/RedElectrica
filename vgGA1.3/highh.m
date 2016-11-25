function res = highh(r, k, varargin)
% highh(r, k, rMin=0)
% 
% Hard to explain but the analoguos of the digits of the
% high part of number r up to value k. The number r
% takes a minimal value of rMin.
% Notice that highh(r,k,rMin)*(k-rMin) = high(r,k,rMin).
% Works for integers and reals with rMin=0. 
% (Needs to be corrected for rMin<>0.)
%
% Example:
%
%   a = [2 1 2 0 0]*(3.^[0 1 2 3 4]')
%
%   a =
%
%      23   
%
%   highh(23,3.^[0 1 2 3 4]) =
%
%      23  7  2   0   0
%
% See also: low, high.

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
res = high(r-rMin,k-rMin)./(k-rMin);
