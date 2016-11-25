function pop = incrementalMOO(pop,cOmega,cDelta,sigma,kOmega,kDelta,varargin)

% pop = incrementalMOO(pop,cOmega,cDelta,sigma,kOmega,kDelta,w=1)

% DON'T USE
% UNDER CONSTRUCTION

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
   w = varargin{1};
else 
   w = 1;
end

noFuns = pop.params.noFunctions;
if length(w)~=noFuns
   w = ones(1,noFuns);
end
if length(varargin)>=2
   alpha = varargin{2};
else
   alpha = 1;
end

% choose random comparisons
% (might be better idea to choose based on age and/or fitness)
n = length(pop.individual);
ind = randperm(n);

for k=1:2:n
   i = ind(k);  
   j = ind(k+1);
   % update omega
   s = sh(pop.individual(i).fitness(1:noFuns),...
      pop.individual(j).fitness(1:noFuns),...
      sigma,w,alpha);
   pop.individual(i).fitness(noFuns+1) = ...
      (1-kOmega)*pop.individual(i).fitness(noFuns+1) + kOmega*s;
   pop.individual(j).fitness(noFuns+1) = ...
      (1-kOmega)*pop.individual(j).fitness(noFuns+1) + kOmega*s;
   
   % update delta
   fi = pop.individual(i).fitness(1:noFuns);
   fj = pop.individual(j).fitness(1:noFuns);
   if sum(fj<=fi)==noFuns && sum(fj<fi)>1      % j dominates i
      Di = 1;
      Dj = 0;
   elseif sum(fi<=fj)==noFuns && sum(fi<fj)>1  % i dominates j
      Di = 0;
      Dj = 1;
   else         % neither one dominates the other
      Di = 0;
      Dj = 0;
   end
   pop.individual(i).fitness(noFuns+2) = ...
      (1-kDelta)*pop.individual(i).fitness(noFuns+2) + kDelta*Di;
   pop.individual(j).fitness(noFuns+2) = ...
      (1-kDelta)*pop.individual(j).fitness(noFuns+2) + kDelta*Dj;
   
   % update fitness
   pop.individual(i).fitness(noFuns+3) = ...
      cOmega*pop.individual(i).fitness(noFuns+1)+ ...
      cDelta*pop.individual(i).fitness(noFuns+2);
   pop.individual(j).fitness(noFuns+3) = ...
      cOmega*pop.individual(j).fitness(noFuns+1)+ ...
      cDelta*pop.individual(j).fitness(noFuns+2);

%    % update age
%    pop.individual(i).age = max(pop.individual(i).age-1,0);
%    pop.individual(j).age = max(pop.individual(j).age-1,0);
end

   
function res = sh(x1,x2,sigma,w,alpha)
% Sharing function
% x1
% x1 = repmat(x1,length(x2),1);
% x1
% x2
% w
d = sqrt((x1-x2).^2*w');
res = (d<sigma).*(1-(d/sigma)).^alpha;
