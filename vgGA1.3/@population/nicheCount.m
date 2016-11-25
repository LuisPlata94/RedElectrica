function pop = nicheCount(pop, sigma, type, varargin)
% population/nicheCount
%
% pop = nicheCount(pop, sigma, type, alpha=1)
%
% Calculates the niche count of type 'phenotypic'(default) or by 'fitness' with 
% given sigma.
%
% type: 'p(henotypic)' or by 'f(itness)'
 
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
   alpha = varargin{1};
else
   alpha = 1;
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);

if isequal(type,'phenotypic') || isequal(type,'phenotype') || ...
      isequal(type,'pheno') || isequal(type,'p') || isequal(type,'P')
   r = reshape([pop.individual.r],pop.params.m,n)';
   for i=1:n
      m = sum(sh(pop.individual(i).r,r,sigma,alpha));
      pop.individual(i).fitness(k+1) = m;
   end
elseif isequal(type,'fitness') || isequal(type,'fit') ||...
      isequal(type,'f') || isequal(type,'F')
   fitness = reshape([pop.individual.fitness],k,n)';
   for i=1:n
      m = sum(sh(pop.individual(i).fitness,fitness,sigma,alpha));
      pop.individual(i).fitness(k+1) = m;
   end
else
   error([type,' is not an implemented type of sharing'])
end



function res = sh(x1,x2,sigma,alpha)
% Sharing function
x1 = repmat(x1,length(x2),1);
d = sqrt(sum((x1-x2).^2,2));
res = (d<sigma).*(1-(d/sigma)).^alpha;


