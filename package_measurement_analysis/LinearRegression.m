function par = LinearRegression(linDATA)
%Ta funkcija sprejme vektor linDATA=[x1;x2;...;xl;y1;y2;...;yl] in 
%vrne vektor par=[k;n] enacbe y=kx+n. 

l=length(linDATA)/2;
x=linDATA(1:l);
y=linDATA(l+1:end);
A=[x,ones(l,1)];
par=A\y;

end

