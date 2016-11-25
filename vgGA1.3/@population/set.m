function pop = set(pop,fieldname,value,varargin)
% population/set
%
% pop = set(pop,fieldname,value)
%
% Sets the value of a given field. Currently implemented fields:
%     type
%     N
%     pc
%     pm
%     delta
%     digits
%     B
%     r (give individual index)
%     max
%     best
     
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

switch(fieldname)
   case 'type'
      pop.params.type = value;
   case 'N'
      pop.params.N = value;
   case 'pc'
      pop.params.pc = value;
   case 'pm'
      pop.params.pm = value;
   case 'delta'
      pop.params.delta = value;
   case 'dist'
      pop.params.dist = value;
   case 'digits'
      pop.params.digits = value;
   case 'B'
      pop.params.B = value;
   case 'r'
      pop.individual(varargin{1}).r = value;
   case 'max'
      pop.params.max = value;
   case 'dChroms'
      pop.params.dChroms = value;
   case 'dPhenos'
      pop.params.dPhenos = value;
   case 'fitness'
       for i=1:length(value)
          pop.individual(i).fitness = value(i);
       end
   case 'best'
      pop.best = value;
   otherwise
  error(strcat(fieldname,' is not a valid field name to set'))
end


