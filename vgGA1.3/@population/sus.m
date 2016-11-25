function pop = sus(pop,varargin)
% population/sus
%
% pop = sus(pop,normalized=0)
%
% Implements stochastic universal selection.
%
% See also: roulette, linRanking, tournament, btournament

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
   normalized = varargin{1};
else
   normalized = 0;
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);

if normalized
   averageFitness = 1;
else
   fitness = reshape([pop.individual.fitness],k,n)';
   f = fitness(:,k);
   averageFitness = mean(f);

   % totalFitness = 0;
   % for i=1:n,
   %   totalFitness = totalFitness + pop.individual(i).fitness(k);
   % end
   % averageFitness = totalFitness/n;
   
   for i=1:n,
      pop.individual(i).fitness(k+1) = ...
         pop.individual(i).fitness(k)/averageFitness;
   end
   k = k + 1;
end


pointer = rand;
sumFitness = 0;
j = n + 1;
i = 1;
while j<=2*n,
   sumFitness = sumFitness + pop.individual(i).fitness(k);
   while sumFitness >= pointer,
      pop.individual(j) = pop.individual(i);
      j = j + 1;
      pointer = pointer + 1;
   end
   i = i + 1;
end
pop.individual = pop.individual(n+1:2*n);


return

% % Another way of doing the above is
% cumFitness = cumsum(f);
% totalFitness = cumFitness(n);
% pointer = rand*averageFitness;
% pointers = [pointer:averageFitness:averageFitness*n];
% for i=1:n
%    j = find(pointers(i)<cumFitness,1);
%    pop.individual(i+n) = pop.individual(j);
% end
% % Keep only the last n individuals
% pop.individual = pop.individual(n+1:2*n);



