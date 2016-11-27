function hijo = transhijo(hijo)
% Funcion que corrige el hecho que hay mas bits que el numero que se ocupa

global N nbits

for t=1:mod(2^nbits,N)
   hijo(hijo==(N+t))=t;
end