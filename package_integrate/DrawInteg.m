function DrawInteg(x,y,limit_points, zone_points,xmin,xmax,zonemin,zonemax,figr)
% DrawInteg narise funkcijo, ki jo bo integriral InerInteg.
if xmax<xmin
    [xmax, xmin] = deal(xmin,xmax);
end

N=1000;
figure(figr)
clf;
hold on;
l=length(limit_points);

xx=x(zone_points(1,:));
yy=y(zone_points(1,:));
n=length(xx);
A=ones(n,n);
for j=2:n
    A(:,j)=power(xx,j-1);
end
a=linsolve(A,yy);
p=flipud(a);
if xmin<limit_points(2)
    X=(linspace(xmin,min(xmax,limit_points(2)),N))';
    Y=polyval(p,X);
    h=area(X,Y);
    h.FaceColor=[0 0 1];
    h.FaceAlpha = 0.3;
end
X=(linspace(min(limit_points(1),xmin),limit_points(2),N))';
Y=polyval(p,X);
plot(X,Y,'r','LineWidth',1.2);

for i=2:l-1
    xx=x(zone_points(i,:));
    yy=y(zone_points(i,:));
    n=length(xx);
    A=ones(n,n);
    for j=2:n
        A(:,j)=power(xx,j-1);
    end
    a=linsolve(A,yy);
    p=flipud(a);
    if xmin>limit_points(i)&&xmin<limit_points(i+1)
        X=(linspace(xmin,min(xmax,limit_points(i+1)),N))';
        Y=polyval(p,X);
        h=area(X,Y);
        h.FaceColor=[0 0 1];
        h.FaceAlpha = 0.3;
    else
        if xmin<limit_points(i)&&xmax>limit_points(i)
            X=(linspace(limit_points(i),min(limit_points(i+1),xmax),N))';
            Y=polyval(p,X);
            h=area(X,Y);
            h.FaceColor=[0 0 1];
            h.FaceAlpha = 0.3;
        end
    end    
    X=(linspace(limit_points(i),limit_points(i+1),N))';
    Y=polyval(p,X);
    plot(X,Y,'r','LineWidth',1.2);
end

xx=x(zone_points(l,:));
yy=y(zone_points(l,:));
n=length(xx);
A=ones(n,n);
for j=2:n
    A(:,j)=power(xx,j-1);
end
a=linsolve(A,yy);
p=flipud(a);
if xmax>limit_points(l)
    X=(linspace(max(xmin,limit_points(l)),xmax,N))';
    Y=polyval(p,X);
    h=area(X,Y);
    h.FaceColor=[0 0 1];
    h.FaceAlpha = 0.3;
end

X=(linspace(limit_points(l),max(max(x),xmax),N))';
Y=polyval(p,X);
plot(X,Y,'r','LineWidth',1.2);



plot(x,y,'bo','MarkerSize',10);


set(gca,'FontSize',14)
grid on;
hold off;

if zonemin==zonemax

    
end

