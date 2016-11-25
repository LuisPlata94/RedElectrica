function res = rMax(rMin,rMaxh,N,B)

% rMax(rMin,rMaxh,N.B)
%
% Returns the adjusted value of rMax:
%    rMin <= r <  rMaxh
%    rMin <= r <= rMax
%
% See also rMaxh

res = (B.^N.*rMaxh - rMin)./(B.^N-1);