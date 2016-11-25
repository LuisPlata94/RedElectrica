function pop = tournament(pop, varargin)
% population/tournament
%
% pop = tournament(pop, m=2)
%
% Implements tournament selection of size m.
%
% See also: roulette, sus, btournament

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
   size = floor(abs(varargin{1}));
else
   size = 2;
end

k = length(pop.individual(1).fitness);
n = length(pop.individual);
ind = [randperm(n) (1:size-1)+n];
pop.individual = [pop.individual pop.individual(ind(1:size-1))];
for i=1:n,
  best = i;
  for j=i+1:i+size-1,
    if pop.params.max == 1
      if pop.individual(ind(j)).fitness(k) > pop.individual(ind(best)).fitness(k)
         best = j;
      end
    else
       if pop.individual(ind(j)).fitness(k) < pop.individual(ind(best)).fitness(k)
          best = j;
       end
    end
  end
  pop.individual(ind(i)) = pop.individual(ind(best));
end
pop.individual = pop.individual(1:n);

return



% ind = randperm(n+size-1);
% for i=1:n,
%   best = i;
%   for j=i+1:i+size-1,
%     if pop.params.max == 1
%       if pop.individual(ind(j)).fitness(k) > pop.individual(ind(best)).fitness(k)
%          best = j;
%       end
%     else
%        if pop.individual(ind(j)).fitness(k) < pop.individual(ind(best)).fitness(k)
%           best = j;
%        end
%     end
%   end
%   pop.individual(ind(i)) = pop.individual(ind(best));
% end
% pop.individual = pop.individual(ind(1:n));
% 
% return
% 
