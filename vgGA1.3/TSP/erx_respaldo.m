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
%*   Manuel Valenzuela-Rendon                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnologico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

% Modified by Guadalupe Valenzuela and Alfonso Palacios


n = length(p1);
  
CreateEdgeTable(p1,p2);
prevCity = 0;
h = zeros(1,n);
for i=1:n
  h(i) = FindMinCity(prevCity);
  RemoveFromEdges(h(i));
  prevCity = h(i);
end

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
    if length(find(lst==p1(k))) == 0
      lst = [lst p1(k)];
    end
    if j == 1
      k = n;
    else
      k = j - 1;
    end
    if length(find(lst==p1(k))) == 0
      lst = [lst p1(k)];
    end
    j = find(p2==i);
    if j == n
      k = 1;
    else
      k = j + 1;
    end
    if length(find(lst==p2(k))) == 0
      lst = [lst p2(k)];
    end
    if j == 1
      k = n;
    else
      k = j - 1;
    end
    if length(find(lst==p2(k))) == 0
      lst = [lst p2(k)];
    end
    lst = sort(lst(2:length(lst))); % this sort is not necessary
                                    % but nice when debugging
    edges{i} = lst;
    lengths(i) = length(lst);
 end
% for i=1:length(edges)
%   edges{i}
% end
% lengths
  
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
%     warning ('evaluando len');
%     len
  end
 
  minEdges = min(len);
%  minEdges
  nMin = sum(len == minEdges);
%  nMin
  randPos = floor(rand*nMin) + 1;
%  randPos
  minLengthCities = find(len == minEdges);
%  minLengthCities
  
  if prevCity == 0
    city = minLengthCities(randPos);
 else
%    prevCity
%    edges{prevCity}
 city = edges{prevCity}(randPos);

 end
  
function RemoveFromEdges(city)
  global edges lengths
  edgesToRemove = edges{city};
  % edgesToRemove
  for i=1:length(edgesToRemove)
    edges{edgesToRemove(i)} = ...
	RemoveFromArray(edges{edgesToRemove(i)},city);
    lengths(edgesToRemove(i)) = lengths(edgesToRemove(i)) - 1;
  end
  lengths(city) = Inf;
% for i=1:length(edges)
%   edges{i}
% end
% lengths
  

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

