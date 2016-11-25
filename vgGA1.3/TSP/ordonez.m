function res = ordonez(chrom)

% permutation = ordonez(chromosome)
%
% Implements Ordonez's representation of permutations.
% Receives a chromosome in direct coding and returns the
% corresponding permutation. Cities are numbered starting with 1.
%
% See also:  cx, erx, ox, pmx

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

res = 1;                                       % start with city 1
for i=2:length(chrom)+1
  pos = mod(chrom(i-1),i) + 1;                 % find position of city i
  res = [res(1:pos-1) i res(pos:length(res))]; % insert city i
end
res = res - 1;
