%% Reloj de Mutación en el vgGA
%
% En este script se demostrarán las ecuaciones del reloj de mutación en el
% vgGA.

%% Mutación sin reloj
% Primero, la densidad de probabilidad para el número de bits entre mutaciones
% para la mutación usual en un AG simple, teórica y experimentalmente.

pm = 0.01;
noMutaciones = 30000;
reloj = 0;
xUsual = [];
bins = 10;
i = noMutaciones;
while i >= 0
   if rand<=pm
      i = i - 1;
      xUsual = [xUsual reloj];
      reloj = 0;
   end
   reloj = reloj + 1;
end
ancho = (max(xUsual)-min(xUsual))/bins;
x = 1:1:max(xUsual);
nUsual = histc(xUsual,x);
nUsual = nUsual/sum(nUsual);
% Distribución geométrica
p = pm;
xn = 1:max(xUsual);
g = (1-p).^(xn-1)*p;
plot(x,nUsual,'r',xn,g,'b')
legend('experimental','teórica')
title(sprintf('Densidad de probabilidad de bits a siguiente mutación (pm=%5.3f)',pm))
xlabel('bits a siguiente mutación')
ylabel('probabilidad')

%% Reloj de mutación para AGS con distribución geométrica
% Ahora, obtenemos la densidad de probabilidad que se obtiene con el reloj
% de mutación de un AG simple
xUnif = rand(1,noMutaciones);
xGeom = ceil( log10(1-xUnif)/log10(1-pm) );
nGeom = histc(xGeom,x);
nGeom = nGeom/sum(nGeom);
plot(x,nGeom,'r',xn,g,'b')
legend('experimental geométrica','teórica')
title(sprintf('Densidad de probabilidad de bits a siguiente mutación (pm=%5.3f)',pm))
xlabel('bits a siguiente mutación')
ylabel('probabilidad')

%% Reloj de mutación para AGS con distribución exponencial
% Ahora, obtenemos la densidad de probabilidad que se obtiene con el reloj
% de mutación de un AG simple
xUnif = rand(1,noMutaciones);
xGeom = ceil((1/pm)*log(1./(1-xUnif)));
nGeom = histc(xGeom,x);
nGeom = nGeom/sum(nGeom);
plot(x,nGeom,'r',xn,g,'b')
legend('experimental exponencial','teórica')
title(sprintf('Densidad de probabilidad de bits a siguiente mutación (pm=%5.3f)',pm))
xlabel('bits a siguiente mutación')
ylabel('probabilidad')


%% Reloj de mutación del vgGA con enteros
xUnif = rand(1,noMutaciones);
phi = (1/pm)*log(1./(1-xUnif)); 
delta = 2;  % ancho de mutación
mEntTrad = traditional(logB(delta) + phi);
nEntTrad = histc(mEntTrad,x);
nEntTrad = nEntTrad/sum(nEntTrad);
plot(x,nEntTrad,'r',xn,g,'b')
legend('experimental enteros tradicional exponecial','teórica')
title(sprintf('Densidad de probabilidad de bits a siguiente mutación (pm=%5.3f)',pm))
xlabel('bits a siguiente mutación')
ylabel('probabilidad')

