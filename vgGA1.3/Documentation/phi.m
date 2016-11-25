function res = phi(x)
r = 0.001;
if x>0.35
   res = x;
else
   res = r*(x-0.35).^2;
end
