function pop = ngeneration(pop)

%  pop = ngeneration(pop)
% 
% IN CONSTRUCTION, DO NOT USE!
% REMOVE FROM DISTRIBUTION

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

warning('IN CONSTRUCTION, DO NOT USE!')

n = length(pop.individual);
k = length(pop.individual(1).fitness);

fitness = reshape([pop.individual.fitness],k,n)';
f = fitness(:,k);

cumFitness = cumsum(f);
averageFitness = mean(f);
totalFitness = cumFitness(n);

pointer = averageFitness/2;
pointers = [pointer+totalFitness/2];

for i=1:2
   j = find(pointers(i)<cumFitness,1);
   pop.individual(i+n) = pop.individual(j);
end
