function DrawZFitPolyFit(Figure, xData, yData, ...
    xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit)
%% Tool for plotting the data points and the regression
%% polynomial curve
% 
% Author: Žan Kogovšek
% Date: 4.22.2023
% Last changed: 11.24.2023
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X 
% and the input vector 'yData' of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), the vector 
% 'pFitPolyFit' of the coefficients of the regression polynomial 
% fPolyFit of the data points represented by the pairs 
% ('xData'(i), 'yData'(i)), and the natural number 'Figure', this 
% function plots the data points and the regression polynomial 
% curve of the data points from the input value of the X variable 
% 'xFitPolyFitMin' to the input value of the X variable 
% 'xFitPolyFitMax'. 
% 
%% Variables
% 
% This function has the form of DrawZFitPolyFit(Figure, ...
% xData, yData, xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit)
% 
% 'Figure' is the parameter the value of which is the index of the 
% figure window  on which the data points and the regression 
% polynomial curve described in the Description section is to be 
% plotted. The value of the 'Figure' parameter must be a natural 
% number. 
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. The values of the 
% 'xData' vector must be in ascending order. 
% 
% The 'xFitPolyFitMin' parameter and the 'xFitPolyFitMax' 
% parameter are two values of the X variable and are the lower 
% and the upper boundary, respectively, of the interval over 
% which the regression polynomial of the data points 
% represented by the pairs ('xData'(i), 'yData'(i)) is to be plotted. 
% The 'xFitPolyFitMax' value must be greater than the 
% 'xFitPolyFitMin' value. 
% 
% 'pFitPolyFit' is the vertical vector of the coefficients of the 
% regression polynomial fPolyFit of the data points represented 
% by the pairs ('xData'(i), 'yData'(i)). The regression polynomial 
% fPolyFit has the form fPolyFit(X) = 'a_n' * (X^n) + 
% 'a_(n - 1)' * (X^(n - 1)) + ... + 'a_1' * X + 'a_0' and the 
% 'pFitPolyFit' vector must have the form 
% ['a_n'; 'a_(n - 1)'; ...; 'a_1'; 'a_0']. 


pars = inputParser;

paramName = 'Figure';
errorMsg = '''Figure'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFitMin';
errorMsg = '''xFitPolyFitMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFitMax';
errorMsg = ...
    '''xFitPolyFitMax'' must be a number which is greater than ''xFitPolyFitMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitPolyFitMax > xFitPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, Figure, xData, yData, ...
    xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit);

% The parameter 'N' is set to be 'N' = 10 000 and represents 
% the number of points for the regression polynomial curve plot. 
% With this setting, the number of points is typically sufficient to 
% create a convincing illusion of the fPolyFit function curve being 
% smooth (as the actual fPolyFit function is, in fact, a smooth 
% function). 
N = power(10, 4);

xFitPolyFit = (linspace(xFitPolyFitMin, xFitPolyFitMax, N))';
yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);

figure(Figure);

plot(xFitPolyFit, yFitPolyFit, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end