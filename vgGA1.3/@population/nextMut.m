function pop = nextMut(pop, i)

% population/nextMut
%
% pop = nextMut(pop, i)
%
% Generates value to next mutation, over segment i.

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

global type digits dist

if pop.params.pm(i) <= 0
  % Do nothing if pm is zero to avoid division by zero
  return
end

type = pop.params.type;
digits = pop.params.digits;
dist = pop.params.dist;
N = pop.params.N(i);
B = pop.params.B(i);
delta = pop.params.delta(i);
rMin = pop.params.rMin(i);
rMax = pop.params.rMax(i);
DeltaRB = (rMax-rMin)/B^N;
pm = pop.params.pm(i);
mPlus = pop.mutclock.mPlus(i);
mMax = pop.mutclock.mMax(i);

% Find raw mPlus
if isequal(dist,'exponential')
   phi = -(1/pm) * log(1-rand);
   mPlus = mPlus + logB(delta,B) + phi;
elseif isequal(dist,'uniform')
   pm = pm * N/B^N;
   phi = -(1/pm) * log(1-rand);
   mPlus = mPlus + logB(delta*(phi+1));
else
   error([dist,' is not a valid distribution']);
end

% Find deltaI and advanced mPlus
deltaI = floor((mPlus+logB(delta,B)-1)/mMax);
mPlus = mPlus - deltaI*mMax;

% Round according to type of digits
if isequal(digits,'traditional')
   mPlus = traditional(mPlus);
elseif isequal(digits,'generalized')
   mPlus = generalized(mPlus,B);
elseif isequal(digits,'continuous')
    % There is nothing to do
    % mPlus = mPlus;
else
   error([digits,' is not a valid digits']);
end

% Find value where mutation is going to occur
if isequal(type,'integer')
   kPlus = floor(B^mPlus);
elseif isequal(type,'real')
   kPlus = (B^mPlus)*DeltaRB + rMin;
else
   error([type,' is not a valid type']);
end

% Save data
pop.mutclock.mPlus(i) = mPlus;
pop.mutclock.DeltaI(i) = deltaI;
pop.mutclock.kPlus(i) = kPlus;

