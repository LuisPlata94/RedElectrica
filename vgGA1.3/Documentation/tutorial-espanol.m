%% Tutorial del vgGA
%
% El *vgGA* está programado orientado a objetos. El vgGA está basado en la 
% clase |population| definida en el directorio |@population/|. En MATLAB
% todos los métodos de una clase deben colocarse en un directorio que 
% empiece con el caracter @ (arroba) y que tenga el mismo nombre de la 
% clase. 
%
% El constructor de la clase debe ser una función con el mismo nombre de 
% la clase, y que regrese una instancia de la clase que se contruya con la 
% función |class|. La forma en que se despliega una instancia de una clase 
% queda determinada por el método |display| que el usuario debe definir.
%
% MATLAB no permite accesar los campos de un objeto fuera de los métodos 
% de ese objeto. Es usual contruir métodos específicos para obtener y 
% modificar campos de una clase. La clase |population| tiene los 
% métodos |get| y |set| para este fin; sin embargo, están % limitados a 
% los campos que se requirieron para pruebas, y no son muy generales. 
%
% En MATLAB, a menos que se declaren globales, todas las variables son 
% locales a las funciones que las utilizan. Los métodos de una clase son 
% simplemente funciones que deben recibir la instancia de la clase sobre 
% la que van a trabajar, y deben regresarla para su asignación si es que 
% deben modificar la instancia. 

%% Creación de una población vacía
% Para crear un objeto |p| de la clase population se utiliza el
% constructor de la clase. Por ejemplo, para crear una población de 
% enteros, con dos segmentos (uno de 6 dígitos binarios, otro de 3 dígitos 
% base 5), con probabilidades de mutación de 0.4 y 0.2, y probablidad de 
% cruce 0.9, se utiliza la siguiente instrucción:
p = population('integer',[6 3],[0.4 0.2],0.9,[2 5])

%% Individuos aleatorios
% Para crear 10 individuos aleatorios se utiliza el método |random| como
% se muestra a continuación.
%
% Para cada individuo se lista su genotipo, fenotipo, y evaluación.  Los
% individuos tiene evaluaciones de |NaN| (_Not a Number_) porque todavía 
% no han sido evaluados.

p = random(p,10)


%% Evaluación
% La población se evalúa con el método |evaluate| que recibe la función 
% objetivo como parámetro.
%
% El método |display| despliega información general de la población: 
% aptitud promedio, desviación estándar de la aptitud de la apitud. 
% También se despliega cuántas evaluaciones se han realizado, en cuál 
% evaluación se encontró el |mejor encontrado|, y el mejor encontrado. En 
% este ejemplo la población se evalúa con la función |x2y2| que es una 
% función que recide en el directorio raíz |vgGA/|, y que regresa la suma 
% de los cuadrados de los segmentos. El método |evaluate| espera una 
% función que reciba un vector que corresponde al fenotipo (campo |r|) de 
% cada individuo, y regresa su evaluación.
p = evaluate(p,@x2y2)

%% Selección
% Para realizar selección de rueda de ruleta sobre la población se aplica 
% el método |roulette| (hay otros métodos de selección implementados en el
% vgGA).
%
% Los métodos |sus| y |tournament| implementan seleccíón universal
% estocástica y selección de torneo, respectivamente.
%
% Nótese que la mayoría de los individuos tienen una evaluación de |NaN|
% porque no han sido evaluados.
p = roulette(p)

%% Cruce y mutación
% Cruce y mutación se realizan con los métodos |crossover| y |mutation|:
p = crossover(p)
p = mutation(p)

%% Algoritmo genético
% Con los métodos |population|, |random|, |evaluate|, |roulette|, 
% |crossover|, y |mutation| es posible crear un algoritmo genético que 
% corra por un número de generaciones y que regrese el individuo _mejor 
% encontrado_ contra el número de evaluaciones de la generación.  El 
% método |runGA| hace lo anterior. En las siguientes instrucciones se 
% corre la población |p| por 50 generaciones y se grafica el mejor 
% encontrado contra el número de evalauciones de la función objetivo:
[p,B] = runGA(p,@x2y2,50);
plot(B(:,1),B(:,2))

%% Curva del mejor encontrado
% Para obtener la |curva del mejor encontrado| existe la función |plotGA| 
% en el directorio raíz |vgGA|. Esta función crea una población y llama 
% repetidamente a |runGA| para luego graficar el promedio, más y menos la  
% desviación estándar, del mejor encontrado de una serie de corridas de un 
% algoritmo genético.  Con la siguiente instrucción se corre el algoritmo 
% genético de este tutorial 20 veces por 50 generaciones.
plotGA(20,50,10,@x2y2,'random',...
   'integer',[6 3],[0.4 0.2],0.9,[2 5]);





