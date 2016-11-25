function value = get(pop,fieldname,varargin)
% population/get
%
% get(pop,fieldname)
%
% Returns the value of a given field

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnólogico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

switch(fieldname)
   case 'type'
      value = pop.params.type;
   case 'n'
      value = length(pop.individual);
   case 'N'
      value = pop.params.N;
   case 'pc'
      value = pop.params.pc;
   case 'pm'
      value = pop.params.pm;
   case 'max'
      value = pop.params.max;
   case 'delta'
      value = pop.params.delta;
   case 'dist'
      value = pop.params.dist;
   case 'digits'
      value = pop.params.digits;
   case 'B'
      value = pop.params.B;
   case 'individual'
      value = pop.individual(varargin{1});
   case 'best'
      value = pop.best;
   case 'evals'
      value = pop.evals;
   case 'noFunctions'
      value = pop.params.noFunctions;
   case 'r'
      value = [pop.individual.r];
      value = reshape(value,pop.params.m,length(pop.individual));
   case 'rr'
      value = [];
      for i=1:length(pop.individual)
         value = [value; pop.individual(i).r pop.individual(i).fitness];
      end
      sort(value);
   case 'fitness'
      value = [];
      for i=1:length(pop.individual)
         value = [value; pop.individual(i).fitness];
      end
   case 'rMax'
      value = pop.params.rMax;     
% NO ES NECESARIO: estaba usando esto para redes de sort, pero
% se obtiene lo mismo tranponiendo lo que regresa 'r'
%    case 'especial'
%       value = [];
%       for i=1:length(pop.individual)
%          value = [value; pop.individual(i).r];
%       end      

   otherwise
      error(strcat(fieldname,' is not a valid field name for a population'))
end
