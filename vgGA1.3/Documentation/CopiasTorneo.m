%% Número esperado de copias en selección de torneo


%% Fórmula aproximada

n = 101;          % tamaño de población
r = 0:n-1;        % ranqueo
M = [2 4 8 16];   % tamaños de torneo
nC = [];
leyenda = {};
for i=1:length(M)
    m = M(i);
% Usando la aproximación
    nCopias = m.*(r./(n-1)).^(m-1);
    nC = [nC;nCopias];    
    leyenda{i} = sprintf('m=%d',m);
end
plot(r,nC,'-')
xlim([0 n-1])
ylim([0 max(M)])
xlabel('ranqueo')
ylabel('número esperado de copias (aproximación)')
title('selección de torneo de tamaño m')
%legend({'m=2','m=4','m=8','m=16'})
legend(leyenda,'Location','NorthWest')
grid on


%% Fórmula exacta

n = 101;          % tamaño de población
r = 0:n-1;        % ranqueo
M = [2 4 8 16];   % tamaños de torneo
nC = [];
leyenda = {};
for i=1:length(M)
    m = M(i);
    prod = m*ones(size(r));
    for j=0:m-2
        prod = prod.*(r-j)./(n-1-j);
    end
    nC = [nC;prod];
    leyenda{i} = sprintf('m=%d',m);
end
plot(r,nC,'-')
xlim([0 n-1])
ylim([0 max(M)])
xlabel('ranqueo')
ylabel('número esperado de copias (número exacto)')
title('selección de torneo de tamaño m')
%legend({'m=2','m=4','m=8','m=16'})
legend(leyenda,'Location','NorthWest')
grid on


%% Error de la aproximación


n = 101;
M = [2 4 8 16];   % tamaños de torneo
M = 2:16;

for i=1:length(M)
   m = M(i);
   r = 0:n-1;

   % Fórmula exacta
   prod = m*ones(size(r));
   for j=0:m-2
      prod = prod.*(r-j)./(n-1-j);
   end
   % Fórmula aproximada
   nCopias = m.*(r./(n-1)).^(m-1);
   
%    for j=1:length(prod)
%       fprintf('%10.7f %10.7f\n',prod(j),nCopias(j))
%    end
%    fprintf('\n')

   plot(r,(prod-nCopias),'.-')
   xlabel('ranqueo')
   ylabel('error = exacta-aprox')
   title(sprintf('torneo de tamaño=%d',m))
   grid on
   pause
end
