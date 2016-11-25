function h = erx(p1, p2)

% h = erx(p1, p2)
%
% Implements Edge Recombination Crossover (ERX) of permutations 
% p1 and p2. 
  
% M. Valenzuela
% 5/16/2002

global edges lengths 

lengths = [];
n = length(p1);
  
CreateEdgeTable(p1,p2);
prevCity = 0;
for i=1:n
  h(i) = FindMinCity(prevCity);
%  fprintf('i = %d\n', i)
  RemoveFromEdges(h(i));
  prevCity = h(i);
end

function CreateEdgeTable(p1,p2)
  global edges lengths
  n = length(p1);
  for i=1:n
    lst = [0];
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
    lst = lst(2:length(lst)); % this sort is not necessary
                                    % but nice when debugging
    edges{i} = lst;
    lengths(i) = length(lst);
  end

function city = FindMinCity(prevCity)
  global edges lengths
  % len: vector of the lengths of previousCity edges
  if (prevCity == 0) | (length(edges{prevCity}) == 0)
    len = lengths;
  else
    len = lengths(edges{prevCity});
  end
  minLen = min(len);           % mimimal edge length to prevCity
  nMin = sum(len == minLen);   % number of minimal edges to prevCity
  iMinLen = find(len==minLen); % indices of minimal lengths in edges
                               % to prevCity
  randPos = floor(rand*nMin) + 1; % random position in iMinLen
  if (prevCity == 0) | (length(edges{prevCity}) == 0)
    city = iMinLen(randPos);
  else
    city = edges{prevCity}(iMinLen(randPos));
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
  
