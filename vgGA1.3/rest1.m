function [g f h] = rest1(x)
% Implemetación de 
%
% f(x) = 1000x - 400x^2 + 40x^3 - x^4
%
% s.a. h(x) = x^2 + x - 500 <= 0

R = 1;

f = 1000*x - 400*x^2+ 40*x^3 - x^4;
h = x^2 + x - 500;

if h<=0
   phi = 0;
else
   phi = h^2;
end

g = f + R*phi;

