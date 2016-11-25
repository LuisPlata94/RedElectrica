%% Tamaño de población


nMin = @(m,k,B,a) ceil(log(1-nthroot(1-a,m))./log(1-B.^(-k)))

%% Prueba para un caso

m = 10;   % número de bloques
k = 5;    % orden de engaño
B = 2;    % base
a = 0.01; % probabilidad de no tener todos los engaños resueltos

nMin(m,k,B,a)

%% Unas gráficas

m = 1:20;
k = [3 4 5];
B = 2;
a = 0.001;

n1 = nMin(m,k(1),B,a);
n2 = nMin(m,k(2),B,a);
n3 = nMin(m,k(3),B,a);

plot(m,n1,'.-',m,n2,'x-',m,n3,'*-')
title(sprintf('Tamaño mínimo de población para a=%f',a))
xlabel('bloques de engaño')
ylabel('n')
legend(sprintf('k=%d',k(1)),sprintf('k=%d',k(2)),sprintf('k=%d',k(3)),...
   'Location','Best')
grid on


%% Y otras

lMax = 120;

m1 = 1:ceil(lMax/k(1));
m2 = 1:ceil(lMax/k(2));
m3 = 1:ceil(lMax/k(3));

n1 = nMin(m1,k(1),B,a);
n2 = nMin(m2,k(2),B,a);
n3 = nMin(m3,k(3),B,a);


plot(m1*k(1),n1,'.-',m2*k(2),n2,'x-',m3*k(3),n3,'*-')
title(sprintf('Tamaño mínimo de población para a=%f',a))
xlabel('longitud del cromosoma')
ylabel('n')
legend(sprintf('k=%d',k(1)),sprintf('k=%d',k(2)),sprintf('k=%d',k(3)),...
   'Location','Best')
grid on