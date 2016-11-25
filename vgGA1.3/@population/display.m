function display(pop)
% population/display
%
% display(pop)
%
% Display a population.

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

CHROMS = pop.params.dChroms;    % Display chromosomes?
PHENOS = pop.params.dPhenos;    % Display phenotypes?
MUT_CLOCK = 0;                  % Display mutation clock?
TRACE = 0;                      % Display tracing info?
BEST = pop.params.dBest;        % Display best?
PARAMS = pop.params.dParams;    % Display parameters?

fprintf('%s =\n\n', inputname(1));
fprintf('   vgGA population:\n\n');
if PARAMS
   fprintf('   parameters:\n\n');
   fprintf('    type: %s\n', pop.params.type);
   fprintf('      pm:');
   for i=1:pop.params.m
      fprintf(' %g', pop.params.pm(i));
   end
   fprintf('\n');
   fprintf('      pc: %g\n', pop.params.pc);
   fprintf('       m: %g\n', pop.params.m);
   fprintf('       B:');
   for i=1:pop.params.m
      fprintf(' %g', pop.params.B(i));
   end
   fprintf('\n');
   fprintf('   delta:');
   for i=1:pop.params.m
      fprintf(' %g', pop.params.delta(i));
   end
   fprintf('\n');
   fprintf('    dist: %s\n', pop.params.dist);
   fprintf('  digits: %s\n', pop.params.digits);
   if isequal(pop.params.type,'real')
      fprintf('    rMin: ');
      for i=1:pop.params.m,
         fprintf('%3d ',pop.params.rMin(i));
      end
      fprintf('\n');
      fprintf('    rMax: ');
      for i=1:pop.params.m,
         fprintf('%3d ',pop.params.rMax(i));
      end
      fprintf('\n');
   end
   fprintf('       N: ');
   for i=1:pop.params.m,
      fprintf('%3d ',pop.params.N(i));
   end
   fprintf('\n');
   if pop.params.inheritance
      fprintf('   alpha: %g\n',pop.params.alpha)
      fprintf('    beta: %g\n',pop.params.beta)
   end
end

if MUT_CLOCK==1
   fprintf('\n   mutation clock:\n\n');
   fprintf('    mMax:');
   for i=1:pop.params.m,
      fprintf(' %4d',pop.mutclock.mMax(i));
   end
   fprintf('\n');
   fprintf('   mPlus:');
   for i=1:pop.params.m,
      fprintf(' %10.4f',pop.mutclock.mPlus(i));
   end
   fprintf('   kPlus:');
   for i=1:pop.params.m,
      if isequal(pop.params.type,'integer')
         fprintf(' %d',pop.mutclock.kPlus(i));
      else
         fprintf(' %10.4f',pop.mutclock.kPlus(i));
      end
   end
   fprintf('\n');
   fprintf('  DeltaI:');
   for i=1:pop.params.m,
      fprintf(' %4d',pop.mutclock.DeltaI(i));
   end
   fprintf('\n');
end

if TRACE==1
   fprintf('no of crossovers = %d, no of IPCs = %d, no of mutations = %d\n',...
      pop.trace.nCross, pop.trace.nIPC, pop.trace.nMuts)
end

if length(pop.individual)>=1
   fprintf('\n');
   fprintf('   individual:\n\n');
   for i=1:length(pop.individual),
      fprintf('    %4d: ',i);
      if isequal(pop.params.type,'real')
         if (CHROMS==1) && sum(pop.params.N==Inf)==0 && isequal(pop.params.digits,'continuous')==0
            % Chromosomes can only be displayed if N<Inf 
            for j=1:pop.params.m
               fprintf('%s ',...
                  dec2base(...
                  round((pop.individual(i).r(j)-pop.params.rMin(j))*...
                  pop.params.B(j)^pop.params.N(j)/pop.params.DeltaR(j)),...
                  pop.params.B(j),pop.params.N(j)));
            end
         end
         if PHENOS
            fprintf('%8.4f ', pop.individual(i).r);
         end
      elseif isequal(pop.params.type,'integer')
         if CHROMS==1
            for j=1:pop.params.m
               fprintf('%s ',...
                  dec2base(pop.individual(i).r(j),...
                  pop.params.B(j), pop.params.N(j)));
            end
         end
         if PHENOS
            fprintf('%7d ', pop.individual(i).r);
         end
      end
      fprintf(' -> ');
      fprintf(' %10.4f', pop.individual(i).fitness);
      if pop.params.inheritance
         fprintf(' %10.4f',pop.individual(i).fTrue)
         fprintf(' %10.4f',pop.individual(i).fEsti)
         fprintf(' %6.4f',pop.individual(i).iCtrl)
      end
      fprintf('\n');
   end
end


if BEST
   % Display average and std dev. of fitness
   n = length(pop.individual);
   if n>0
      k = length(pop.individual(1).fitness);
      fitness = reshape([pop.individual.fitness],k,n)';
      f = fitness(:,1);
      %   fMin = min(f);
      %   fMax = max(f);
      average = mean(f);
      stddev = std(f);
      %    fitnesses = [];
      %    for i=1:length(pop.individual)
      %       fitnesses = [fitnesses pop.individual(i).fitness(1)];
      %    end
      %    average = mean(fitnesses);
      %    stddev = std(fitnesses);
      fprintf('\n   Average fitness:%10.4f,   std dev:%10.4f', ...
         average, stddev)
   end
   
   % Display best found so far
   
   if pop.params.max == 1
      str = 'max';
   else
      str = 'min';
   end
   
   fprintf('\n   Best (%s) found at evaluation %d, after %d evaluations:\n',...
      str, pop.best.evals, pop.evals);
   fprintf('    BEST: ');
   if isequal(pop.params.type,'real')
      if (CHROMS==1) && sum(pop.params.N==Inf)==0 && ~isequal(pop.params.digits,'continuous')
         % Chromosomes can only be displayed if N<Inf
         for j=1:pop.params.m
            fprintf('%s ',...
               dec2base(...
               round((pop.best.r(j)-pop.params.rMin(j))*...
               pop.params.B(j)^pop.params.N(j)/pop.params.DeltaR(j)),...
               pop.params.B(j), pop.params.N(j)));
         end
      end
      if PHENOS
         fprintf('%8.4f ', pop.best.r);
      end
   elseif isequal(pop.params.type,'integer')
      if CHROMS==1
         for j=1:pop.params.m
            fprintf('%s ',...
               dec2base(pop.best.r(j),pop.params.B(j),pop.params.N(j)));
         end
      end
      if PHENOS
         fprintf('%5d ', pop.best.r);
      end
   end
   fprintf(' -> ');
   fprintf(' %10.4f', pop.best.fitness);
   fprintf('\n');
end % BEST

if pop.params.inheritance
   fprintf('\n   inheritance:\n');
   fprintf('   error: %g\n',pop.params.error);
end
  

