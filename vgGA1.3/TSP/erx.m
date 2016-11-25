function h = erx(p1, p2)

% h = erx(p1, p2)
%
% Implements Edge Recombination Crossover (ERX) 
% of permutations p1 and p2. 
%
% See also:  cx, ox, pmx

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

% Modified by Guadalupe Valenzuela and Alfonso Palacios
% Should check and correct the warnings about isempty(find(x,1))

p1 = p1 + 1;
p2 = p2 + 1;


n = length(p1);
  
CreateEdgeTable(p1,p2);
prevCity = 0;
h = zeros(1,n);
for i=1:n
  h(i) = FindMinCity(prevCity);
  RemoveFromEdges(h(i));
  prevCity = h(i);
end
h = h - 1;

function CreateEdgeTable(p1,p2)
  global edges lengths
  n = length(p1);
  for i=1:n
    lst = 0;
    j = find(p1==i);
    if j == n
      k = 1;
    else
      k = j + 1;
    end
    if isempty(find(lst==p1(k)))
      lst = [lst p1(k)];
    end
    if j == 1
      k = n;
    else
      k = j - 1;
    end
    if isempty(find(lst==p1(k)))
      lst = [lst p1(k)];
    end
    j = find(p2==i);
    if j == n
      k = 1;
    else
      k = j + 1;
    end
    if isempty(find(lst==p2(k)))
      lst = [lst p2(k)];
    end
    if j == 1
      k = n;
    else
      k = j - 1;
    end
    if isempty(find(lst==p2(k)))
      lst = [lst p2(k)];
    end
    lst = sort(lst(2:length(lst))); % this sort is not necessary
                                    % but nice when debugging
    edges{i} = lst;
    lengths(i) = length(lst);
 end
  
function city = FindMinCity(prevCity)
  global edges lengths
  if prevCity == 0
    len = lengths;
  else
     len = lengths(edges{prevCity});
     if isempty(len)
        len = lengths;
        prevCity = 0;
     end
  end
 
  minEdges = min(len);
  nMin = sum(len == minEdges);
  randPos = floor(rand*nMin) + 1;
  minLengthCities = find(len == minEdges);
  
  if prevCity == 0
    city = minLengthCities(randPos);
  else
    city = edges{prevCity}(randPos);
 end
  
function RemoveFromEdges(city)
  global edges lengths
  edgesToRemove = edges{city};
  for i=1:length(edgesToRemove)
    edges{edgesToRemove(i)} = ...
	RemoveFromArray(edges{edgesToRemove(i)},city);
    lengths(edgesToRemove(i)) = lengths(edgesToRemove(i)) - 1;
  end
  lengths(city) = Inf;

function res = RemoveFromArray(array,element)
  where = array==element;
  k = 1;
  res = [];
   for i=1:length(array)
    if where(i) == 0
      res(k) = array(i);
      k = k + 1;
    end
  end

