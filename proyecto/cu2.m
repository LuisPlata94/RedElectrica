function r = cu2(x)
r=zeros(1,length(x));
for t=1:length(x);
    if (0<x(t))&&(x(t)<=5)
        r(t)=10;
    elseif (5<x(t))&&(x(t)<=10)
        r(t)=15;
    elseif (10<x(t))&&(x(t)<=20)
        r(t)=20;
    elseif (20<x(t))&&(x(t)<=40)
        r(t)=30;
    elseif (40<x(t))&&(x(t)<=80)
        r(t)=40;
    end
end