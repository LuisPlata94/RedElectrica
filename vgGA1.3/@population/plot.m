function [x,f] = plot(pop,varargin)
% population/plot
%
% plot(pop,plotStyle='or')
%
% Plots all the individuals of a population. Individuals must be of a 
% single segment.

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
   plotStyle = varargin{1};
else
   plotStyle = 'or';
end
x = [];
f = [];
if pop.params.m ~= 1
  error('Cannot plot for m>1')
end
for i=1:length(pop.individual)
  x = [x; pop.individual(i).r];
  f = [f; pop.individual(i).fitness(1)];
end
plot(x(:,1),f,plotStyle)
  
