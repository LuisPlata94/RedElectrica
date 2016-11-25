function plotMOO(pop,varargin)

% plotMOO(pop)
% plotMOO(pop, axisLimits1, axisLimits2)
% 
% Plots a population for multiobjective optimization in the objective
% functions space (only the case of 2 objective functions is currently
% implemented). If m=2, the population is also plotted in the domain space.  

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

f = get(pop,'fitness');
noF = pop.params.noFunctions;

if noF~=2 
   error('Can only plot for 2 objective functions')
end

notDom = find(f(:,noF+2)==0);
Dom = find(f(:,noF+2)>0);
if pop.params.m == 2
   subplot(2,1,1)
end
if isempty(notDom)
   plot(f(Dom,1),f(Dom,2),'.r')
   legend('dominated','Location','Best')
elseif isempty(Dom)
   plot(f(notDom,1),f(notDom,2),'.b')
   legend('not dominated','Location','Best')
else
   plot(f(Dom,1),f(Dom,2),'.r',f(notDom,1),f(notDom,2),'.b')
   legend('dominated','not dominated','Location','NorthEast')
end
if length(varargin)>=1
   axis(varargin{1})
end
grid on
xlabel('f_1')
ylabel('f_2')
evals = get(pop,'evals');
title(sprintf('dominated=%d, not dominated=%d, evals=%d',...
   length(Dom),length(notDom),evals))

% I need to implement the case of m=1 and m=3
if pop.params.m == 2
   rr = get(pop,'rr');
   x = rr(:,1);
   y = rr(:,2);
   subplot(2,1,2)
   plot(x(Dom),y(Dom),'.r',x(notDom),y(notDom),'.b')
   if length(varargin)>=2
      axis(varargin{2})
   end
   xlabel('x_1')
   ylabel('x_2')
   grid on
end

