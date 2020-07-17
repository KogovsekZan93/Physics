function yDeriv = FinDifMeth(xData,yData,xDeriv,ordDeriv,acc)

%% Finite difference method differentiation
% 
% Author: Žan Kogovšek
% Date: 7.6.2018
% 
%% Description
% 
% Given the pairs of values of the independent variable x and the
% dependent variable y of an arbitrary function y = f(x), this 
% function returns the value of an arbitrary derivative of the
% function f in an arbitrary set of values of the dependent variable
% with an arbitrary order of accuracy using the finite difference
% method.
% 
%% Variables
% 
% This function has the form of 
% yDeriv = FinDifMeth(xData,yData,xDeriv,ordDeriv,acc).
% 
% xData and yData are the aforementioned pairs of values of the 
% independent variable x and the dependent variable y 
% (yData(i) = f(xData(i))). xData and yData have to be proper 
% vectors (that is in column form).
% 
% xDeriv is the aformentioned set of values of the dependent 
% variable x at which the derivative will be calculated. xDeriv has 
% to be a proper vector (that is in column form).
% 
% ordDeriv is the order of the derivative that will be calculated. 
% ordDeriv has to be a natural number.
% 
% acc is the accuracy of the calculated derivative. acc has to be a
% natural number.
%
% yDeriv is the output of the FinDifMeth function. It is a proper 
% vector (that is in column form). The values of the elements of 
% yDeriv are as follows:
% yDeriv(i) = d^ordDeriv(f(x)) / x^ordDeriv | x = xDeriv(i)

    function polyDeriv = DerPoly(expo,oDer,xv)
        
%%        Polynomial derivative
% 
%         PolyDeriv function returns the oDer'th derivative of the
%         function f(x) = x^expo at x = xev.
%         
%         The retuned value is calculated using the formula:
%         d^oDer(x^expo) / dx^oDer = binomial(expo,oDer) * oDer! * (x^(expo - oDer))
%         
%         The following "if statement" covers the undefined values  
%         of binomial(expo < oDer,oDer).

        if expo < oDer
            polyDeriv = 0;
        else
            polyDeriv = nchoosek(expo,oDer) * factorial(oDer) * power(xv,expo-oDer);
        end
    end

npoints = acc + ordDeriv;
N = length(xDeriv);
yDeriv = zeros(N,1);

for i = 1:N
    xDataSet = xData;
    indSet = zeros(npoints,1);
    
%     In the following loop, the indeces of npoints elements of 
%     xData with the closest values to the value of the i-th element 
%     of xDeriv are found.

    for j = 1:npoints
        [~,indSet(j)] = min(abs(xDeriv(i) - xDataSet));
        
%         In the following line, it is assured that the same element
%         of xData is not selected twice.

        xDataSet(indSet(j)) = 2 * max(abs(xDeriv(i) - xDataSet)) + xDeriv(i);
    end
    indSet = sort(indSet);
    
%     In the following line, it is assured that the values of the
%     dependent variable are small so that their values to a 
%     potentially high power will not be too high.

    xSet = (xData(indSet) - xDeriv(i));
    ySet = yData(indSet);

%     In the following lines, we solve the problem demonstrated in 
%     the following comment lines for the example of
%     FinDifMeth(xData=[x1;x2;x3],yData=[y1;y2;y3],xDeriv,ordDeriv=1,acc=2):
%     
%     y1 = x1 - xDeriv(i)
%     y2 = x2 - xDeriv(i)
%     y3 = x3 - xDeriv(i)
%     
%     A * a = b
% 
%     | 1            1       1     |    *   |a0|   =  |                   0                   |
%     | y1         y2      y3    |        |a1|       |                    1                  |
%     | y1^2   y2^2    y3^2 |        |a2|       | 2 * (xDeriv(i) - xDeriv(i)) |

    A=zeros(npoints,npoints);
    b=zeros(npoints,1);
    
    for k = 1:npoints
        b(k) = DerPoly(k - 1,ordDeriv,0);
        A(k,:) = (power(xSet,k - 1))';
    end
    a = (A \ b)';
    
    yDeriv(i) = a * ySet;
    
end

end

