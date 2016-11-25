function res = rMaxh(rMin,rMax,N,B)

% rMaxh(rMin,rMax,N,B)
%
% This is the inverse of rMax.
%
% See also rMax
res = rMax - (rMax-rMin)/B^N;



