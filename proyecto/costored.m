function costo = costored(hijo)

global N D prod caso

% Función de costo unitario
switch caso
    case 1
        costoUnitario = @(capacidad)  2 + capacidad.^0.6;
    otherwise
        costoUnitario= @(capacidad) cu2(capacidad);
end
% +1 Por el 0 que se genera
% Arreglar el exceso de bits con transhijo
% Ponerle el 0 del almacen
hijo = [0,transhijo(hijo+1)];

% Matriz de incidencias
A = zeros(N);
for i=1:N
    if hijo(i)~=0
        A(i,hijo(i)) = 1;
    end
end

% Verificar si la red es valida
r=checkred(hijo);

if r==0 % Se cumple que esta bien conectada    
    % Calculo de corriente en cada arista del arbol
    Aux = A;
    envia = zeros(1,N);    % potencia que envía cada nodo a su padre
    while 1
        hojas = find(sum(Aux,1)==0);  % si el nodo raíz es hoja,
        if isequal(hojas,1)           % salir
            break
        end
        envia(hojas) = envia(hojas) + prod(hojas);
        for i=1:length(hojas)
            envia(hijo(hojas(i))) = envia(hijo(hojas(i)))+envia(hojas(i));
            Aux(hojas(i),:) = zeros(size(hijo));
        end
        Aux(1,hojas) = 1;
    end
    
    % Costo por arista
    costo = sum(costoUnitario(envia).*[0;diag(D(2:N,hijo(2:N)))]');
%     if r>0
%         % Funcion de castigo
%         costo=costo + 500;
%         %costo=costo+mean(prod)*(r^2);
%     end
else
    % Otra funcion de castigo
    costo = 800;
    %costo = r*costoUnitario(mean(prod)) + mean(prod)*(r^2);
end