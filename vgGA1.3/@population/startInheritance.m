function pop = startInheritance(pop,varargin)

% population/startInheritance
%
% pop = startInheritance(pop,weighted=0,alpha=0.1,beta=0.7)
%
% Starts inheritance in a population.
% USE WITH CAUTION: UNDER CONSTRUCTION

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

pop.params.inheritance = 1;

if length(varargin)>=1
   pop.params.weighted = varargin{1};
else
   pop.params.weighted = 0;
end
   
if length(varargin)>=2
   pop.params.alpha = varargin{2};
else
   pop.params.alpha = 0.1;   % No good reason for this value
end

if length(varargin)>=3
   pop.params.beta = varargin{3};
else
   pop.params.beta = 0.7;    % No good reason for this value
end


for i=1:length(pop.individual)
   pop.individual(i).fTrue = pop.individual(i).fitness;
   pop.individual(i).fEsti = NaN; 
   pop.individual(i).iCtrl = 1;
end

pop.params.error = 0;

