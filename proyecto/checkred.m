function r = checkred(x)
% Funcion para checar si una red es valida
global N
if any(x==1)
    list=1;
    for t=1:N-1
        a=find(x==list(t));
        list=[list,a];
        if length(list)==t
            r=N-t;
            break
        end
        if length(list)==N
            r=0;
            break
        end
    end
else
    r=N-1;
end