function pop = distribute(pop)
% population/distribute
%
% pop = share(pop)
% 
% Alterative to sharing that should work on functions with plateuas.
% Distance to closest individual is maximized.
% DO NOT USE: UNDER CONSTRUCTION
% DOES NOT WORK
 
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

n = length(pop.individual);
k = length(pop.individual(1).fitness);
[pop.individual.fitness]
f = reshape([pop.individual.fitness],k,n)';
r = reshape([pop.individual.r],pop.params.m,n)';

D = Inf*ones(n,n);
for i=1:n
   % Find distances
   for j=1:n
      if j~=i
         D(i,j) = norm(r(i,:)-r(j,:));
      end
   end
end
% find minimal distance
[dMin,jMin] = min(D,[],2);
for i=1:n
   pop.individual(i).fitness(k+1) = dMin(i);
end
