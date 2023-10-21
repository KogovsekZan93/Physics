function DrawZIntegralPolyFit(Figure, xData, yData, ...
    xIntegralPolyFitMin, xIntegralPolyFitMax, ...
    ColorFace, pFitPolyFit)
%% Tool for plotting the data points, the regression
%% polynomial curve, and the area under the curve over 
%% an interval
% 
% Author: Žan Kogovšek
% Date: 3.19.2023
% Last changed: 10.21.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "pFitPolyFit" of the coefficients of the regression polynomial 
% fPolyFit of the data points represented by the pairs 
% ("xData"(i), "yData"(i)), the values of the X variable the 
% "xIntegralPolyFitMin" value and the "xIntegralPolyFitMax" 
% value, the natural number "Figure", and the vector 
% "ColorFace", this function plots the data points, the regression 
% polynomial curve of the data points, and the area under the 
% regression polynomial curve from "xIntegralPolyFitMin" to 
% "xIntegralPolyFitMax", the color of the area being defined by 
% the RGB triplet of numbers of the "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZIntegralPolyFit...
% (Figure, xData, yData, xIntegralPolyFitMin, ...
% xIntegralPolyFitMax, ColorFace, pFitPolyFit)
% 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points, the regression polynomial 
% curve, and the area under the curve described in the 
% Description section is to be plotted. The value of the "Figure" 
% parameter must be a natural number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xIntegralPolyFitMin" parameter and the 
% "xIntegralPolyFitMax" parameter are two values of the X 
% variable and are the lower and the upper boundary, 
% respectively, of the area to be plotted using this function under 
% the regression polynomial curve of the data points 
% represented by the pairs ("xData"(i), "yData"(i)). The 
% "xIntegralPolyFitMax" value must be greater than the 
% "xIntegralPolyFitMin" value. 
% 
% "ColorFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the regression polynomial curve of the 
% data points represented by the pairs ("xData"(i), "yData"(i)) 
% from the value "xIntegralPolyFitMin" to the 
% "xIntegralPolyFitMax" value. The three real numbers must be 
% values of the [0, 1] interval. 
% 
% "pFitPolyFit" is the vertical vector of the coefficients of the 
% regression polynomial fPolyFit of the data points represented 
% by the pairs ("xData"(i), "yData"(i)). The regression polynomial 
% fPolyFit has the form fPolyFit(X) = "a_n" * (X^n) + 
% "a_(n - 1)" * (X^(n - 1)) + ... + "a_1" * X + "a_0" and the 
% "pFitPolyFit" vector must have the form 
% ["a_n"; "a_(n - 1)"; ...; "a_1"; "a_0"]. 


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

paramName = 'xIntegralPolyFitMin';
errorMsg = '''xIntegralPolyFitMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralPolyFitMax';
errorMsg = ...
    '''xIntegralPolyFitMax'' must be a number which is greater than ''xIntegralPolyFitMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralPolyFitMax > xIntegralPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

parse...
    (pars, Figure, xData, xIntegralPolyFitMin, xIntegralPolyFitMax);

figure(Figure);

% In the following block of code, the area under the regression 
% polynomial curve is plotted. 
DrawZAreaPolyFit(xIntegralPolyFitMin, xIntegralPolyFitMax, ...
    ColorFace, pFitPolyFit)

hold on;

% In the following block of code, the regression polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) as well as the data points themselves 
% are plotted. 
DrawZFitPolyFit(Figure, xData, yData, ...
    min(xData(1), xIntegralPolyFitMin), ...
    max(xData(end), xIntegralPolyFitMax), pFitPolyFit)

end