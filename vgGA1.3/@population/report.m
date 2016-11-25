function report(pop,varargin)
% population/report
%
% report(pop,fileID)
% report(pop)
%
% Reports a population to a file or to the screen.
% (This methods needs to be checked for the latest changes.)

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

CHROMS = 0;
INDS = 0;

if length(varargin)>=1
   fileID = varargin{1};
else
   fileID = 1;
end

if (length(pop.individual)>=1) && INDS
   fprintf(fileID,'\n');
   fprintf(fileID,'   individual:\n\n');
   for i=1:length(pop.individual),
      fprintf(fileID,'      %2d: ',i);
      if isequal(pop.params.type,'real')
         if CHROMS==1
            for j=1:pop.params.m
               fprintf(fileID,'%s ',...
                  dec2bin(...
                  (pop.individual(i).r(j)-pop.params.R(j,1))*...
                  pop.params.B^pop.params.N(j)/pop.params.DeltaR(j),...
                  pop.params.N(j)));
            end
         end
         fprintf(fileID,'%8.4f ', pop.individual(i).r);
      elseif isequal(pop.params.type,'integer')
         if CHROMS==1
            for j=1:pop.params.m
               fprintf(fileID,'%s ',...
                  dec2bin(...
                  pop.individual(i).r(j),...
                  pop.params.N(j)));
            end
         end
         fprintf(fileID,'%5d ', pop.individual(i).r);
      end
      fprintf(fileID,' -> ');
      fprintf(fileID,' %10.4f\n', pop.individual(i).fitness);
   end
end

if INDS == 1
   fprintf(fileID,'\n   Best found after %d evaluations at evaluation %d:\n',...
      pop.evals, pop.best.evals);
   fprintf(fileID,'    BEST: ');
else
   fprintf(fileID,'%5d %5d ', pop.evals, pop.best.evals);
end
if isequal(pop.params.type,'real')
   if CHROMS==1
      for j=1:pop.params.m
         fprintf(fileID,'%s ',...
            dec2bin(...
            (pop.best.r(j)-pop.params.R(j,1))*...
            pop.params.B^pop.params.N(j)/pop.params.DeltaR(j),...
            pop.params.N(j)));
      end
   end
   fprintf(fileID,'%8.4f ', pop.best.r);
elseif isequal(pop.params.type,'integer')
   if CHROMS==1
      for j=1:pop.params.m
         fprintf(fileID,'%s ',...
            dec2bin(...
            pop.best.r(j),...
            pop.params.N(j)));
      end
   end
   fprintf(fileID,'%5d ', pop.best.r);
end
fprintf(fileID,' -> ');
fprintf(fileID,' %10.4f\n', pop.best.fitness);
 
