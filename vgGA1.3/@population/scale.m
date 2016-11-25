function pop = scale(pop, varargin)
% population/scale
%
% pop = scale(pop, Cmult=2)
%
% Implements linear scaling.

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

global fMin fMax fAvg Cmult

if length(varargin)>=1
   Cmult = varargin{1};
else
   Cmult = 2;
end


n = length(pop.individual);
k = length(pop.individual(1).fitness);

fitness = reshape([pop.individual.fitness],k,n)';
f = fitness(:,k);
fMin = min(f);
fMax = max(f);
fAvg = mean(f);

if f1(fMin) >= 0
   fp = f1(f);
else
   fp = f2(f);
end
for i=1:n
   pop.individual(i).fitness(k+1) = fp(i);
end

function fp = f1(f)
global fMax fAvg Cmult
fp = (f-fAvg) * (Cmult-1) / (fMax-fAvg) + 1;

function fp = f2(f)
global fMin fMax Cmult
fp = (f-fMin) * Cmult / (fMax-fMin);




  
  

