function Integ = InterInteg(x,y,xmin,xmax,n,figr)
%% Generalized numerical integration
% 
% Author: Žan Kogovšek
% Date: 28.4.2020
% 
%% Description
% 
% Given the pairs of values of the independent variable x and the
% dependent variable y of an arbitrary function y = f(x), this 
% function returns the value of the integral of the function f(x)
% with the limits of integration xmin and xmax. The integration is 
% performed with a pseudo-order of accuracy n and is visualized 
% in the figure(figr) plot.
% 
%% Variables
% 
% This function has the form of 
% Integ = InterInteg(x,y,xmin,xmax,n,figr)
% 
% x and y are the aforementioned pairs of values of the 
% independent variable x and the dependent variable y 
% (y(i) = f(x(i)). x and y have to be proper vectors (that is in 
% column form).
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval.
% 
% n is the pseudo-order of accuracy of the integration.
% 
% figr is the index of the figure in which the integration is to be
% visualized. If figr = 0, the integration will not be visualized.
% 
% Integ is the output of the InterInteg function and it is the 
% numerical integral of the function f(x) with the limits of 
% integration xmin and xmax 
% value of the integral of p(x) with the limits of integration xmin 
% and xmax.
%
%% Pseudo-order of accuracy integration principle
% 
% This function uses the GetPointsInteg function to divide the x 
% axis into several intervals. In every interval I there is a set S(I) 
% of n x(i) points. For each point P in the interval I, the x(i) points 
% which are in the set S(I) are the closest n x(i) points to the 
% point P.
% In each interval I the f(x) function is approximated by the 
% Lagrange polynomial p(I) of the pairs of x(i) points in the set 
% S(I) and the corresponding y(i) points. In other words, the 
% Lagrange polynomial p(I), which is the approximation of the 
% f(x) function over the interval I, is based on the set 
% {(x(i),y(i)) | x(i) is in S(I)}. This approximation of the function f(x) 
% is then integrated with the limits of integration xmin and xmax.

%     In the following lines, the x and y values are sorted so that in 
%     principle the input x and y values do not have to be. 

[x,I] = sort(x);
y = y(I);

%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. If the input xmax < xmin, Integ, i.e. the 
%     output value, will be multiplied by -1 (k). See Line 130.

k = 1;
if xmax < xmin
    [xmax,xmin] = deal(xmin,xmax);
    k = -1;
end

%     In the following line, the limits for the intervals are calculated 
%     and given in the limit_points variable together with the 
%     corresponding sets S, each of wich is represented by the 
%     corresponding row in zone_points variable. 

[limit_points, zone_points] = GetPointsInteg(x,n);


%     In the following lines the intervals in which xmin and xmax 
%     are located (represented by indices zonemin and zonemax 
%     respectively) are found. 

len_points = length(limit_points);
zonemin = len_points;
zonemax = len_points;

for i = 1:len_points
    if limit_points(i) > xmin
        zonemin = max(i-1,1);
        break;
    end
end

for i = 1:len_points
    if limit_points(i) >= xmax
        zonemax = max(i-1,1);
        break;
    end
end

%     In the following lines, the numerical integration is visualized 
%     by the use of DrawInteg function.

if figr ~= 0
    DrawInteg(x,y,limit_points, zone_points,xmin,xmax,figr);
end

%     Finally, the integral is calculated by summing the appropriate 
%     integrals of the approximation of f(x) function over each 
%     interval. The appropriate integrals over each interval are the 
%     integrals over all intervals between intervals in which xmin 
%     and xmax are located and the integrals of parts of the 
%     intervals in which xmin and/or xmax are located.

if zonemin == zonemax
    Integ = SmallInteg(x(zone_points(zonemin,:)),y(zone_points(zonemin,:)),xmin,xmax);
else
    Integ = SmallInteg(x(zone_points(zonemin,:)),y(zone_points(zonemin,:)),xmin,limit_points(zonemin + 1))+SmallInteg(x(zone_points(zonemax,:)),y(zone_points(zonemax,:)),limit_points(zonemax),xmax);
    if zonemax-1 ~= zonemin
        for i = 1:zonemax - zonemin - 1
            Integ=Integ + SmallInteg(x(zone_points(zonemax - i,:)),y(zone_points(zonemax - i,:)),limit_points(zonemax - i),limit_points(zonemax - i + 1));
        end
    end
end

%     In the following line, if the input xmax < xmin, Integ is 
%     multiplied by -1.

Integ = Integ * k;

end



