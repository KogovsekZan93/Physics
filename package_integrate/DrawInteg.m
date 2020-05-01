function DrawInteg(x,y,limit_points, zone_points,xmin,xmax,figr)
%% Visualization of numerical integration with InterInteg
% 
% Author: Žan Kogovšek
% Date: 1.5.2020
% 
%% Description
% 
% Using this function, the visualization of the numerical 
% integration with InerInteg is plotted in figure(figr). The input 
% values of the independent variable x and the dependent 
% variable y of an arbitrary function y = f(x) are plotted as blue 
% circles, the approximation of the f(x) function is plotted as a 
% red line and the integral is plotted as the semi-transparent blue 
% area under the red curve. 
% 
%% Variables
% 
% This function has the form of 
% DrawInteg(x,y,limit_points, zone_points,xmin,xmax,figr)
% 
% x and y are the aforementioned pairs of values of the 
% independent variable x and the dependent variable y 
% (y(i) = f(x(i)). x and y have to be proper vectors (that is in 
% column form).
% 
% limit_points is a column vector. For any x in 
% [limit_points(I), limit_points(I+1)] the plotted approximation of 
% f(x) function will be the Lagrange polynomial which is based on 
% the set {(x(i),y(i)) | x(i) is in zone_points(:,I)}. For 
% x < limit_points(1) the Lagrange polynomial is based on the set 
% set {(x(i),y(i)) | x(i) is in zone_points(:,1)} and for 
% x > limit_points(end) the Lagrange polynomial is based on the 
% set {(x(i),y(i)) | x(i) is in zone_points(:,end)}.
% 
% zone_points is a matrix. Every row I contains a set of x(i) 
% points. Sets {(x(i),y(i)) | x(i) is in zone_points(:,I)} are used for 
% the calculation of the Lagrange polynomials which are used to 
% approximate the f(x) function.
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. 
% 
% figr is the index of the figure in which the integration is to be
% visualized. 

%     N represents the number of points with which each section 
%     of the approximation of the f(x) function and the integral will 
%     be plotted. 

N = 1000;

figure(figr)
clf;
hold on;

l = length(limit_points);

%     The following lines contain three sections, each separated 
%     from the next by an empty line. They deal with the x values 
%     lower than limit_points(1) (first section), higher than 
%     limit_points(end) (third section) and the intermediary values 
%     (second section). In each section, the p coefficients of the 
%     appropriate Lagrange polynomial are calculated. Then the 
%     Lagrange polynomial is plotted over an appropriate interval.
%     Finally, the area under the curve representing the integral is 
%     plotted. 

xx = x(zone_points(1,:));
yy = y(zone_points(1,:));
n = length(xx);
A = ones(n,n);
for j = 2:n
    A(:,j) = power(xx,j-1);
end
a = linsolve(A,yy);
p = flipud(a);
if xmin < limit_points(2)
    X = (linspace(xmin,min(xmax,limit_points(2)),N))';
    Y = polyval(p,X);
    h = area(X,Y);
    h.FaceColor = [0,0,1];
    h.FaceAlpha = 0.3;
end
X = (linspace(min(limit_points(1),xmin),limit_points(2),N))';
Y = polyval(p,X);
plot(X,Y,'r','LineWidth',1.2);

for i=2:l-1
    xx = x(zone_points(i,:));
    yy = y(zone_points(i,:));
    n = length(xx);
    A = ones(n,n);
    for j = 2:n
        A(:,j)=power(xx,j - 1);
    end
    a=linsolve(A,yy);
    p=flipud(a);
    if xmin > limit_points(i)&&xmin < limit_points(i + 1)
        X = (linspace(xmin,min(xmax,limit_points(i + 1)),N))';
        Y = polyval(p,X);
        h = area(X,Y);
        h.FaceColor = [0,0,1];
        h.FaceAlpha = 0.3;
    else
        if xmin<limit_points(i)&&xmax>limit_points(i)
            X = (linspace(limit_points(i),min(limit_points(i+1),xmax),N))';
            Y = polyval(p,X);
            h = area(X,Y);
            h.FaceColor = [0,0,1];
            h.FaceAlpha = 0.3;
        end
    end    
    X = (linspace(limit_points(i),limit_points(i+1),N))';
    Y = polyval(p,X);
    plot(X,Y,'r','LineWidth',1.2);
end

xx = x(zone_points(l,:));
yy = y(zone_points(l,:));
n = length(xx);
A = ones(n,n);
for j=2:n
    A(:,j) = power(xx,j-1);
end
a = linsolve(A,yy);
p = flipud(a);
if xmax > limit_points(l)
    X = (linspace(max(xmin,limit_points(l)),xmax,N))';
    Y = polyval(p,X);
    h = area(X,Y);
    h.FaceColor = [0,0,1];
    h.FaceAlpha = 0.3;
end
X = (linspace(limit_points(l),max(max(x),xmax),N))';
Y = polyval(p,X);
plot(X,Y,'r','LineWidth',1.2);

%     In the following line, the input pairs of values (x,y) are 
%     plotted.

plot(x,y,'bo','MarkerSize',10);

set(gca,'FontSize',14)
grid on;
hold off;
    
end

