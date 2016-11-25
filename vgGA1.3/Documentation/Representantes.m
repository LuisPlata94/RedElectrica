%% Número esperado de representantes de esquemas 
% En este script se obtiene el número promedio de representantes de dos
% esquemas después de selección y cruce dados dos esquemas y una población
% incial
% 
% La población inicial es la siguiente:
%    crom    x  f(x)
%    00101   5    5
%    01010  10	  10
%    10111  23	  23
%    11011  27	  27
%    10011  19	  19
%    01100  12	  12
%
% Y los esquemas son los siguientes:
%
%    H1 = 1**1*
%    H2 = *0***

clc

%% Crear la población inicial

n = 6;   % tamaño de población
N = 5;   % longitud del cromosoma
pc = 1;  % probabilidad de cruce
pm = 0;  % probabilidad de mutación
p = population('i',N,2*pm,pc);
p = random(p,n);
p = fill(p);
p = set(p,'r',bin2dec('00101'),1);
p = set(p,'r',bin2dec('01010'),2);
p = set(p,'r',bin2dec('10111'),3);
p = set(p,'r',bin2dec('11011'),4);
p = set(p,'r',bin2dec('10011'),5);
p = set(p,'r',bin2dec('01100'),6);
p = evaluate(p,@x);
p = setDisplay(p,{'best',0,'chroms',1,'params',0});
p0 = p;
display(p)
fprintf('\n')

%% Definir esquemas (en forma bipolar)

H1 = [1 0 0 1 0];
o1 = sum(abs(H1)); % orden del esquema
H2 = [0 -1 0 0 0];
o2 = sum(abs(H2));
d1 = 3;
d2 = 0;

%% Representantes de cada esquema

croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
rep1 = find(croms*H1'==o1)';
rep2 = find(croms*H2'==o2)';
f = get(p0,'r');
fprintf('%d representantes de H1:',length(rep1))
fprintf(' %d',rep1)
fprintf('\n\n')
fprintf('%d representantes de H2:',length(rep2))
fprintf(' %d',rep2)
fprintf('\n\n')

%% selección proporcional (valores esperados)
fb = sum(f)/n;
fnorm = f/fb;
f1 = f(rep1);
m1s = sum(f(rep1))/fb;
m1c = m1s*(1-pc*d1/(N-1));
m1m = m1s*(1-pc*d1/(N-1)-pm*o1);
f2 = f(rep2);
m2s = sum(f(rep2))/fb;
m2c = m2s*(1-pc*d2/(N-1));
m2m = m2s*(1-pc*d2/(N-1)-pm*o2);
fprintf('Selección proporcional (número esperado de representantes)\n')
fprintf('   selección  cruce   mutación     selección  cruce   mutación\n')
fprintf('H1: %f %f %f  H2: %f %f %f\n\n',...
   m1s,m1c,m1m,m2s,m2c,m2m)

%% selección por ranqueo (valores esperados)
[Y,I] = sort(f);
r(I) = 2*(0:n-1)/(n-1);
fpb = sum(r)/n;
fpnorm = r/fpb;
fp1 = r(rep1);
m1s = sum(r(rep1));
m1c = m1s*(1-pc*d1/(N-1));
m1m = m1s*(1-pc*d1/(N-1)-pm*o1);
fp2 = r(rep2);
m2s = sum(r(rep2));
m2c = m2s*(1-pc*d2/(N-1));
m2m = m2s*(1-pc*d2/(N-1)-pm*o2);
fprintf('Selección por ranqueo (número esperado de representantes)\n')
fprintf('   selección  cruce   mutación     selección  cruce   mutación\n')
fprintf('H1: %f %f %f  H2: %f %f %f\n\n',...
   m1s,m1c,m1m,m2s,m2c,m2m)



%% Número de representantes después de selección y cruce

%selec = @roulette;
selec = @sus;
%selec = @tournament;

m1 = [0 0 0];
m2 = [0 0 0];
ciclos = 20000;
for i=1:ciclos
   p = selec(p0);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1s = sum(croms*H1'==o1);
   m2s = sum(croms*H2'==o2);
   p = crossover(p);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1c = sum(croms*H1'==o1);
   m2c = sum(croms*H2'==o2);
   p = mutation(p);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1m = sum(croms*H1'==o1);
   m2m = sum(croms*H2'==o2);   
   m1 = m1 + [m1s m1c m1m];
   m2 = m2 + [m2s m2c m2m];
end
mean1 = m1/ciclos;
mean2 = m2/ciclos;

fprintf('Tipo de selección: %7s, ciclos=%d (número de representantes)\n',func2str(selec),ciclos)
fprintf('   selección  cruce   mutación     selección  cruce   mutación\n')
fprintf('H1: %f %f %f  H2: %f %f %f\n\n',...
   mean1(1),mean1(2),mean1(3),mean2(1),mean2(2),mean2(3))
 

%% Promedio y desviación estándar del número de representantes

%selec = @roulette;
selec = @sus;
%selec = @tournament;

m1 = [];
m2 = [];
ciclos = 20000;
for i=1:ciclos
   p = selec(p0);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1s = sum(croms*H1'==o1);
   m2s = sum(croms*H2'==o2);
   p = crossover(p);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1c = sum(croms*H1'==o1);
   m2c = sum(croms*H2'==o2);
   p = mutation(p);
   croms = 2*(dec2bin(get(p,'r'),N) == '1')-1;
   m1m = sum(croms*H1'==o1);
   m2m = sum(croms*H2'==o2);   
   m1 = [m1; [m1s m1c m1m]];
   m2 = [m2; [m2s m2c m2m]];
end
mean1 = mean(m1);
mean2 = mean(m2);
std1 = std(m1);
std2 = std(m2);

fprintf('Tipo de selección: %7s, ciclos=%d\n',func2str(selec),ciclos)
fprintf('   selección  cruce   mutación     selección  cruce   mutación\n')
fprintf('H1: %f %f %f  H2: %f %f %f\n',...
   mean1(1),mean1(2),mean1(3),mean2(1),mean2(2),mean2(3))
fprintf('    %f %f %f  H2: %f %f %f\n\n',...
   std1(1),std1(2),std1(3),std2(1),std2(2),std2(3))

