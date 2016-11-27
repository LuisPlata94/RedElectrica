%% Función objetivo para el problema de red eléctrica
%
% Éste es un pequeño script que muestra cómo se podrían hacer los cálculos
% para evaluar la función objetivo para el problema de la red eléctrica.
%
% M.Valenzuela
%
% Los nodos se numeran a partir de 0, donde 0 es la subestación.
%
% El arreglo hijo contiene el hijo del nodo i-1. En este arreglo el
% hijo se numera a partir de 0, donde 0 indica que no tiene  
% indica que no tiene hijos (todos los nodos, excepto la subestación, 
% deben tener un hijo) 1 se refiere a la subestación (nodo 0). Por ejemplo, 
% en el caso 1, hijo(1)=0 es el hijo de la subestación (nodo 0) que no 
% tiene hijo, hijo(2)=5 indica que el hijo del nodo 1 es 4, etc.
%
% El arreglo prod contiene la producción del nodo i-1.
%
% Cada renglón del arreglo C contiene las coordenadas del nodo i-1.
%
% N es el número de nodos contando a la subestación.

%% Datos caso 1

% hijo del nodo i-1
%       0 1 2 3 4 5 6
hijo = [0 5 4 6 1 5 6];
%hijo = [0 1 2 7 2 2 4];

% Producción del nodo i-1
%       0 1 2 3 4 5 6
prod = [0 10 5 3 4 9 8];

% Coordenadas del nodo i-1
%     0   1   2   3   4    5    6
C = [0 0;3 2;6 2;6 0;3 -2;6 -2;9 -2];

N = length(hijo);

%% Datos caso 2

% hijo del nodo i-1
hijo = [0 3 7 3 4 7 9 6 1 7 10];

% Producción del nodo i-1
prod = [0 3 3 3 10 4 5 5 14 12 2];

% Coordenadas del  nodo i-1
C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2; 4 2; 1 3; 3 3; 5 3];

N = length(hijo);

%% Datos caso 3

% hijo del nodo i-1
%       0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
hijo = [0 14  7  3  4  7  9  6 15  7 10  8  8  1  1];

% Producción del nodo i-1
prod = [0 3 3 3 10 4 5 5 14 12 2 5 8 10 13];

% Coordenadas del nodo i-1
C = [0 1.5; 1 0; 2 0; 3 0; 5 0; 3 1.5; 2 2; 4 2; 1 3; 3 3; 5 3; 5 1;5 2;0 0;0 3];

N = length(hijo);

%% Gráfica de la red con producción

delta = 0.1; % deplazamiento de las etiquetas
plot(C(1,1),C(1,2),'sr',C(2:end,1),C(2:end,2),'ob')
xlim([min(C(:,1))-0.5 max(C(:,1)+0.5)]);
ylim([min(C(:,2))-0.5 max(C(:,2)+0.5)]);
hold on
for p=2:N
   h = hijo(p);
   %fprintf('p=%d h=%d\n',p,h)
   text(C(p,1)+delta,C(p,2)+delta,sprintf('%d:%d',p-1,prod(p)))
   plot([C(p,1) C(h,1)],[C(p,2) C(h,2)],'-b')
   %pause
end
text(C(1,1)+delta,C(1,2)+delta,'0')
hold off
title('Red eléctrica (nodo:producción)')
xlabel('x')
ylabel('y')


%% Conversión de padre a matriz de incidencias

A = zeros(N);
for i=1:N
   if hijo(i)~=0
      A(i,hijo(i)) = 1;
   end
end
% Matriz de inicidencias
display(A)

%% Conversión de A a padre (sólo para mostrar que es posible)

hijo = zeros(1,size(A,1));
for i=2:size(A,1)
   h = find(A(i,:)==1);
   if isempty(h)
      hijo(i) = 0;
   else
      hijo(i) = h;
   end
end
display(hijo)

%% Cálculo de corriente en cada arista del árbol

Aux = A;
envia = zeros(size(hijo));    % potencia que envía cada nodo a su padre
while 1
   hojas = find(sum(Aux,1)==0);  % si el nodo raíz es hoja,
   if isequal(hojas,1)           % salir
      break
   end
   envia(hojas) = envia(hojas) + prod(hojas);  
   for i=1:length(hojas)
      envia(hijo(hojas(i))) = envia(hijo(hojas(i))) + envia(hojas(i));
      Aux(hojas(i),:) = zeros(size(hijo));
   end
   Aux(1,hojas) = 1;
   %display(A);
end
display(envia)


%% Mismo que anterior, pero usando operaciones sobre conjuntos

% No usar, es muy lento
pad = hijo;
envia = zeros(size(pad));
U = 1:N;
while 1
   hojas = setdiff(U,pad);
   if isequal(hojas,1)
      break
   end
   U = setdiff(U,hojas);
   envia(hojas) = envia(hojas) + prod(hojas);
   for i=1:length(hojas)
      envia(pad(hojas(i))) = envia(pad(hojas(i))) + envia(hojas(i));
   end
   pad(hojas) = 0;
end
display(envia)

%% Gráfica de red con producción y cantidad que se envía

delta = 0.1; % desplazamiento de las etiquetas
plot(C(1,1),C(1,2),'sr',C(2:end,1),C(2:end,2),'ob')
xlim([min(C(:,1))-0.5 max(C(:,1)+0.5)]);
ylim([min(C(:,2))-0.5 max(C(:,2)+0.5)]);
hold on
for p=2:N
   h = hijo(p);
   text(C(p,1)+delta,C(p,2)+delta,sprintf('%d:%d/%d',p-1,prod(p),envia(p)))
   plot([C(p,1) C(h,1)],[C(p,2) C(h,2)],'-b')
end
text(C(1,1)+delta,C(1,2)+delta,'0')
hold off
title('Red eléctrica (nodo:producción/envía)')
xlabel('x')
ylabel('y')

%% Cálculo de costos

% Función de costo unitario para caso 1 (debe cambiarse para los casos 2 y 3)
costoUnitario = @(capacidad)  2 + capacidad.^0.6;

% La matriz de distancias contiene la distancia del nodo i-1 al nodo j-i
D = zeros(N);
for i=1:N
   for j=i+1:N
      D(i,j) = norm(C(i,:)-C(j,:));
      D(j,i) = D(i,j);
   end
end
% Matriz de distancias
display(D)

costo = zeros(1,N);
for i=2:N
   costo(i) = costoUnitario(envia(i))*D(i,hijo(i));
end

% Costo por arista
display(costo)
fprintf('El costo total es: %f\n',sum(costo))


%% Cálculo de costos (en forma vectorial)
%
% Esto corre más rápido porque utiliza operaciones matriciales

% Función de costo unitario para caso 1 (debe cambiarse para el caso 2 y 3)
costoUnitario = @(capacidad)  2 + capacidad.^0.6;

% La matriz de distancias contiene la distancia del nodo i-1 al nodo j-i
D = zeros(N);
for i=1:N
   for j=i+1:N
      D(i,j) = norm(C(i,:)-C(j,:));
      D(j,i) = D(i,j);
   end
end
% Matriz de distancias
display(D)

costo = costoUnitario(envia).*[0;diag(D(2:N,hijo(2:N)))]';

% Costo por arista
display(costo)
fprintf('El costo total es: %f\n',sum(costo))


%% Prueba de velocidad
%
% Estas pruebas demuestran que para los casos 2 y 3 la forma vectorial 
% de calcular los costos es más rápida.

nPruebas = 50000;
tini = tic;
for j=1:nPruebas
   for i=2:N
      costo(i) = costoUnitario(envia(i))*D(i,hijo(i));
   end
end
tf1 = toc(tini);

tini = tic;
for j=1:nPruebas
   costo = costoUnitario(envia).*[0;diag(D(2:N,hijo(2:N)))]';
end
tf2 = toc(tini);

fprintf('Tiempo no vectorial = %6.2fs\n',tf1)
fprintf('Tiempo vectorial    = %6.2fs\n',tf2)

% Conclusión:
% Parece que 


