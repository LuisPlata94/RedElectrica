function res = rMax(rMin,rMaxh,N,B)

% rMax(rMin,rMaxh,N,B)
%
% Returns the adjusted value of rMax so that defined in the range 
% [rMin, rMax(rMin,rMaxh,N,B)] will have a maximum value of rMaxh.
% It converts the range  rMin<=r<rMaxh into the range rMin<=r<=rMax.
%
% See also rMaxh

res = (B.^N.*rMaxh - rMin)./(B.^N-1);