function yDerivativeA = ZDerivativeA(xData, yData, xDerivativeA, varargin)
%% Finite difference numerical differentiation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values xData(i) of the independent variable X and 
% the values yData(i) of the dependent variable Y of an arbitrary 
% function Y = f(X), this function returns the value of the 
% ordDeriv-th derivative of the f function for values xDeriv(i) of 
% the independent variable X. The differentiation is performed 
% with the finite difference method with the order of accuracy 
% Acc, i.e. the differentiation is accurate if the f function is a 
% polynomial of the degree of Acc of less. 
% The actual function being differentiated (i.e. the piecewise 
% polynomial interpolation which is the approximation of the f 
% function) can either be visualized in the figure figure(figr) if figr 
% is a natural number or not if figr == 0. 
% 
%% Variables
% 
% This function has the form of 
% yDeriv = ZDerivativeA(xData, yData, ordDeriv, acc, xDeriv, figr, mode)
% 
% xData and yData are the vectors of the aforementioned values 
% xData(i) and yData(i), respectively, of the independent variable 
% X and of the dependent variable Y, respectively, of an arbitrary 
% function Y = f(X) (yData(i) = f(xData(i)). xData and yData both 
% have to be column vectors of real numbers of equal length. 
% xData vector does not have to be sorted (i.e. it is not required 
% that xData(i) > xData(j) for every i > j). 
% 
% ordDeriv is the order of the differentiation. It has to be an 
% integer contained in the interval [1, length(xData) – Acc]. 
% 
% Acc is the order of accuracy of the differentiation, i.e. the 
% differentiation is accurate if the f function is a polynomial of the 
% degree of Acc of less. It has to be an integer contained in the 
% interval [1, length(xData) – ordDeriv]. 
%
% xDeriv is a vector of values of the independent variable X in 
% which the value of the derivative of the f function is to be 
% calculated. The values of the xDeriv vector do not have to be 
% contained in the [min(xData), max(xData)] interval. 
% 
% figr is the index of the figure in which the actual function being 
% differentiated (i.e. the piecewise polynomial interpolation which 
% is the approximation of the f function) will be visualized. It has 
% to be a nonnegative integer. If figr == 0, the differentiation will 
% not be visualized. 
% 
% mode is the selected mode of differentiation. 
%       If mode == 0, the basic mode of differentiation will be 
%       performed. The derivative in each point xDeriv(i) will be 
%       calculated based on the values of the f function in the 
%       closest Acc + ordDeriv values of the xData vector to the 
%       xDeriv(i). 
%       If mode == 1, an augmented mode of the basic mode of 
%       differentiation will be performed. In this mode, the 
%       derivative in each point xDeriv(i) will be calculated based 
%       on the values of the f function in the closest 
%       Acc + ordDeriv values of the xData vector to the xDeriv(i) 
%       with the constraint that xDeriv(i) has to be both less than 
%       the largest and greater than the smallest of the values of 
%       the Acc + ordDeriv values of the xData vector if possible. 
%       If mode == 2, an augmented mode of the basic mode of 
%       differentiation will be performed. In this mode, the 
%       derivative in each point xDeriv(i) will be calculated based 
%       on the values of the f function in the closest 
%       Acc + ordDeriv values of xData to the xDeriv(i) with the 
%       constraint that no more than 1 + ((Acc + ordDeriv) / 2) 
%       values of xData are to be either larger or smaller than 
%       xDeriv(i) if possible.
%
% yDeriv is the output of the ZDerivativeA function and it is the 
% vector of the values of the derivative of the order of ordDeriv 
% of the f function (F := d^(ordDeriv) f / dX^(ordDeriv)) for the X 
% values of xDeriv (yDeriv(i) = F(xDeriv(i))) calculated with the 
% finite difference method with the order of accuracy Acc.


%     In the following lines, the x and y values are sorted. 

%     In the following line, the borders for the intervals I(k) are 
%     calculated. The I(k) intervals are defined as follows: for all 
%     xDeriv(i) values in I(k), the corresponding yDeriv(i) values 
%     are calculated based on the same Acc + ordDeriv pairs of 
%     values (xData(k), yData(k)). The borders of the intervals and 
%     the associated pairs of values depend on the "mode" 
%     parameter. 

[FigureParameter, NonFigureParameters] = SeparateOptionalParameter(varargin, 'Figure');


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Accuracy';
defaultVal = 2;
errorMsg = '''Accuracy'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
errorMsg = '''Mode'' must be either ''0'', ''1'', or ''2''.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn)

parse(pars, xData, NonFigureParameters{:});

ordDeriv = pars.Results.OrdDeriv;
acc = pars.Results.Accuracy;
mode = pars.Results.Mode;


nA = acc + ordDeriv;

if nA > length(xData)
    error('''Accuracy + OrdDeriv'' must be equal to or lower than ''length(xData)''.');
end

[Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode);

yDerivativeA = IpointsSmatrixDerivativeValue(xData, yData, xDerivativeA, ordDeriv, Ipoints, Smatrix);

%     In the following lines, the coefficients of the Lagrange 
%     polynomials with which the f function is approximated over 
%     appropriate I(k) intervals as well as the coefficients of the 
%     polynomials which are the derivatives of the Lagrange 
%     polynomials are calculated. 

%     In the following lines, if 0 ~= 0, the approximation of the f 
%     function is visualized by the use of the DrawfApproximation 
%     function. 

%     Finally, the intervals in which individual xDeriv(i) points are 
%     located are identified and the numerical differentiation of the 
%     f function is performed in each xDeriv(i) point. 

DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, min(xDerivativeA(1), xData(1)), max(xDerivativeA(end), xData(end)), Ipoints, Smatrix};
DecideIfDrawZ(DrawZFitAHandle, DrawZFitAInput, FigureParameter{:});

end