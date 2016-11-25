function [pop,B] = runGA(pop,objective_function,generations,varargin)
% population/runGA
%
% [pop, B] = runGA(pop, objective_function, generations)
% [pop, B] = runGA(pop, objective_function, generations, report_file_name)
% [pop, B] = runGA(pop, objective_function, generations, report_file_name, permission)
%
% Runs the GA cycle (selection, crossover, mutation) over a
% population for the given number of generations.  A report of the
% best found is displayed on screen and filed in the report_file.  If no
% report_file_name is given, results are reported only to the screen. 
% The default permission to open the report file is 'w'.
%
% See also: plotGA
  
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

PLOT = 0; % use PLOT=1 to show the distribution of the population
          % in optimization of f(x) for a real scalar x.
  
if isempty(pop.individual)
  B = [];
  warning('population is empty')
  return
end


if length(varargin) >= 2
   permission = varargin{2};
else
   permission = 'w';
end

if length(varargin) >= 1
   fileID = fopen(varargin{1}, permission);
   fileFlag = 1;
else
   fileFlag = 0;
end

if pop.evals == 0
   pop = evaluate(pop, objective_function);
end
report(pop);
if fileFlag
   report(pop, fileID);
end

B = [pop.evals, pop.best.fitness(1), pop.best.r];


% This is the main cycle of the genetic algorithm.
% The user should modify it to accommodate his/her needs.
for gen=1:generations
   % Linear scaling
   % pop = scale(pop,2);
   
   % Sharing
   % pop = share(pop,0.1,'p');
   
   % Choose type of selection
   % pop = roulette(pop);
   % pop = sus(pop);
   pop = tournament(pop,2);
   % pop = btournament(pop,@testBtour);
   
   pop = crossover(pop);
   pop = mutation(pop);
   pop = evaluate(pop, objective_function);
   
   if PLOT
     plot(pop)
   end
   report(pop);
   if fileFlag
      report(pop, fileID);
   end
   B = [B; pop.evals, pop.best.fitness(1), pop.best.r];
end

if fileFlag
   fclose(fileID);
end
%
