function r = checkred(x)
% Funcion para checar si una red es valida
n=length(x)-1;
if any(x==1)
    list=1;
    for t=1:n
        a=find(x==list(t));
        list=[list,a];
        if length(list)==t
            r=0;
            break
        end
        if length(list)==n+1
            r=1;
            break
        end
    end
else
    r=0;
end