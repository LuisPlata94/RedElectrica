function pop = setDisplay(pop,displayList)
% population/setDisplay
%
% pop = setDisplay(pop,displayList)
%
% Sets display parameters:
%     best: display best individual found so far
%   chroms: display chromosomes
%   phenos: display phenotypes
%   params: display population parameters
% 
% For example pop=setDisplay(pop,{'best',1,'chroms',0,'params',0}) sets the
% population to display the best individual, and not display chromosomes
% and population parameters.
%
% See also: population/display

% Other display parameters should be included in this function

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

for i=1:2:length(displayList)
   if isequal(displayList{i},'best')
      pop.params.dBest = displayList{i+1};
   elseif isequal(displayList{i},'chroms')
      pop.params.dChroms = displayList{i+1};
   elseif isequal(displayList{i},'phenos')
      pop.params.dPhenos = displayList{i+1};
   elseif isequal(displayList{i},'params')
      pop.params.dParams = displayList{i+1};
   else
      error('Not a valid display parameter');
   end
end
