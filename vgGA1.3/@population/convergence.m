function res = convergence(pop, varargin)
% population/convergence
%
%  diversity = convergence(pop, type='fitness')
%
%  Calculates the diversity of the population given a type of convergence
%  used to measure it. 
%  Type can be 'g(enotypic)', p(henotypic)', or by 'f(itness)' (default)

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
   type = 'fitness';
end

if isequal(type,'genotypic') || isequal(type,'genotype') || ...
      isequal(type,'geno') || isequal(type,'g') || isequal(type,'G')
   type = 'g';
elseif isequal(type,'phenotypic') || isequal(type,'phenotype') || ...
      isequal(type,'pheno') || isequal(type,'p') || isequal(type,'P')
   type = 'p';
elseif isequal(type,'fitness') || isequal(type,'fit') || ...
      isequal(type,'f') || isequal(type,'F')
   type = 'f';
else
   error([type,' is not a valid type of convergence'])
end

n = length(pop.individual);
if n<2
   res = 0;
   return
end

if isequal(type,'p')
   % Phenotypic convergence
   r = reshape([pop.individual.r],pop.params.m,n)';
   %avg = mean(r)
   sd = std(r);
   if isequal(pop.params.type,'real')
      res = mean(sd./pop.params.DeltaR);
   elseif isequal(pop.params.type,'integer')
      res = mean(sd./pop.params.B.^pop.params.N);
   end

elseif isequal(type,'f')
   % Convergence by fitness
   k = length(pop.individual(1).fitness);
   fitness = reshape([pop.individual.fitness],k,n)';
   %avg = mean(fitness)
   sd = std(fitness);
   res = mean(sd);
   
elseif isequal(type,'g')
   % Genotypic convergence
   % This code is still very rough and should be improved 
   % for better performance
   if isequal(pop.params.type,'real')
      for i=1:n
         s = '';
         for j=1:pop.params.m
            aux = dec2base(...
               round((pop.individual(i).r(j)-pop.params.rMin(j))*...
               pop.params.B(j)^pop.params.N(j)/pop.params.DeltaR(j)),...
               pop.params.B(j),pop.params.N(j));
            s = [s aux];
         end
         geno(i,:) = s;
      end
   elseif isequal(pop.params.type,'integer')
      for i=1:n
         s = '';
         for j=1:pop.params.m
            aux = dec2base(pop.individual(i).r(j),...
               pop.params.B(j), pop.params.N(j));
            s = [s aux];
         end
         geno(i,:) = s;
      end
   end
   N = sum(pop.params.N);
   for i=1:n
      for j=1:N
         g(i,j) = base2dec(geno(i,j),36); %This is not elegant
      end
   end
   gm = max(g);
   for i=1:N
      for j=0:gm(i)
         c(j+1) = length(find(g(:,i)==j));
      end
      cm(i) = max(c);
   end
   res = (n-mean(cm))/n;
end
