function res = ordonezB(chrom)

% permutation = ordonezB(chromosome)
%
% Implements Ordoñez's representation of permutations.
% Receives a chromosome in binary coding and returns the
% corresponding permutation.
%
% See also:  ordonez

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

jAnt = 0;
j = 1;
i = 1;
while j<=length(chrom)
   chromDirect(i) = bin2dec(sprintf('%d',chrom(jAnt+1:j)));
   i = i + 1;
   jAnt = j;
   j = j + ceil(log2(i+1)); % j=j+K(i)
end
res = ordonez(chromDirect);

% bits required to represent positions in direct coding
% K = ceil(log2([1:MAX_CITIES]+1));
