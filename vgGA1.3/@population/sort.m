function pop = sort(pop,varargin)
% population/sort
%
% pop = sort(pop,type='fitness',order='direct')
%
% Sorts the population by phenotype or by fitness.
%
%  type: 'f(itness)', 'p(henotype)' (default) 
% order: 'inverse', 'd(irect)' (default) 

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
   type = varargin{1};
else
   type = 'f';
end

if length(varargin)>=2
    order = varargin{2};
else
    order = 'd';
end


if isequal(type,'phenotypic') || isequal(type,'phenotype') || ...
      isequal(type,'pheno') || isequal(type,'p') || isequal(type,'P')
   type = 'p';
elseif isequal(type,'fitness') || isequal(type,'fit') || ...
      isequal(type,'f') || isequal(type,'F')
   type = 'f';
else
   error(['Sort population by ''',type,''' not implemented'])
end

if isequal(order,'direct') || isequal(order,'d')
    order = 'd';
elseif isequal(order,'inverse') || isequal(order,'i')
    order = 'i';
else
    error(['Sort population in ',order,' ''order'' not implemented'])
end

n = length(pop.individual);
if isequal(type,'f')
   k = length(pop.individual(1).fitness);
   fitness = reshape([pop.individual.fitness],k,n)';
   [Y,I] = sortrows(fitness);

elseif isequal(type,'p')
   r = reshape([pop.individual.r],pop.params.m,n)';
   [Y,I] = sortrows(r);
end

if pop.params.max==1 && isequal(order,'d') || ...
        pop.params.max==0 && isequal(order,'i')
    I = I(n:-1:1);
end

pop.individual = pop.individual(I);
