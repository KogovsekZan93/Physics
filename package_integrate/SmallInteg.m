function SResul = SmallInteg(x,y,xmin,xmax)
% SmallInteg vrne integral interpolacijskega polinoma funkcije y(i) = y(x(i)) 
% med mejama xmin in xmax.
n=length(x);
A=ones(n,n);
for i=2:n
    A(:,i)=power(x,i-1);
end
a=linsolve(A,y);
for i=1:n
    a(i)=a(i)/i;
end
a=[0;a];
p=flipud(a);
SResul=polyval(p,xmax)-polyval(p,xmin);



end

