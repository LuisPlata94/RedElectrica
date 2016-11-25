function pop = injection(pop,fraction,objective_function)

% population/injection
%
% pop = injection(pop,fraction,objective_function)
%
% Retains the (fraction) best individuals and completes the 
% population with random individuals which are evaluated with
% objective_function.

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

pop = sort(pop);
n = length(pop.individual);
nf = round(n*fraction);
pop.individual = pop.individual(1:nf);
pop = random(pop,n-nf,'y');
pop = evaluate(pop,objective_function);
