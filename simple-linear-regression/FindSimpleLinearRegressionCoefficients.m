function [Slope, Intercept, varargout] = ...
    FindSimpleLinearRegressionCoefficients...
    (xData, yData, varargin)
%% Tool for finding the slope and the intercept of the 
%% simple linear regression curve of the data
% 
% Author: Žan Kogovšek
% Date: 10.17.2023
% Last changed: 2.4.2024
% 
%% Description
% 
% Given the input column vectors 'xData' of the values 'xData'(i) 
% of the independent variable X and the column vector 'yData' 
% of values 'yData'(i) of the dependent variable 
% Y = f(X) = X * a + b, this function returns the estimated values 
% for the a ('Slope') and b ('Intercept') parameters using simple 
% linear regression of the data points ('xData'(i), 'yData'(i)). 
% Additionally, if no optional input parameters are provided, the 
% estimated variance of the 'yData'(i) values can be obtained as 
% the first optional output parameter 'Variance_yData'. The 
% second optional output parameter is the 
% 'CovarMat_SlopeIntercept' matrix, which is the covariance 
% matrix of the 'Slope' and 'Intercept' parameters. If the optional 
% input parameter 'CovarMat_yData', which is the covariance 
% matrix of the values of the 'yData' vector, is provided, the 
% optional output parameter is solely the 
% 'CovarMat_SlopeIntercept' covariance matrix. 
% 
%% Variables
% 
% This function has the form of [Slope, Intercept, varargout] = ...
% FindSimpleLinearRegressionCoefficients...
% (xData, yData, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function Y = f(X) = X * a + b 
% ('yData' = f('xData')) where the a and the b parameters are to 
% be estimated by this function by using simple linear 
% regression. 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. 
% 
% 'varargin' represents the optional input parameter 
% 'CovarMat_yData'. 'CovarMat_yData' is the covariance matrix 
% of the values of the 'yData' vector. It must be a matrix of real 
% numbers. 
% 
% Both the 'Slope' parameter and the 'Intercept' parameter are 
% estimates of the a parameter and the b parameter, 
% respectively, calculated by simple linear regression of the data 
% pairs ('xData'(i), 'yData'(i)) and, if provided, by taking into 
% account the 'CovarMat_yData' covariance matrix of the 
% 'yData'(i) values. 
% 
% 'varargout' represents the optional output parameters which is 
% either the 'CovarMat_SlopeIntercept' covariance matrix alone 
% if the optional input parameter 'CovarMat_yData' is provided, 
% or the 'Variance_yData' variance and the 
% 'CovarMat_SlopeIntercept' covariance matrix if not. 
%    -'CovarMat_SlopeIntercept' is the covariance matrix of the 
%     'Slope' parameter and the 'Intercept' parameter. The 
%     covariance matrix of the dependent data, which is required 
%     for the calculation of the 'CovarMat_SlopeIntercept' 
%     covariance matrix, is either the input parameter 
%     'CovarMat_yData' if provided, or the to be determined value 
%     of the 'Variance_yData' variance if not. 
%    -'Variance_yData' is the estimated variance of the 'yData'(i) 
%     based on the assumptions that 
%          (1) the function f: yData = f(xData) is linear, 
%          (2) the data represented by the values 'xData'(i) have 
%                zero variance, and 
%          (3) the values of the variance of the data represented by 
%                the 'yData'(i) values are equal to each other. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ... 
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'CovarMat_yData';
defaultVal = 0;
errorMsg = ...
    '''CovarMat_yData'' must be a matrix of real numbers';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ...
    isreal(x), errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, yData, varargin{:});
CovarMat_yData = pars.Results.CovarMat_yData;

length_xData = length(xData);

H = [xData, ones(length_xData, 1)];

if sum(sum(CovarMat_yData)) ~=0
    CovarMat_SlopeIntercept = inv((H' / CovarMat_yData) * H);
    varargout = {CovarMat_SlopeIntercept};
    Coefficients = ...
        (CovarMat_SlopeIntercept * (H') / CovarMat_yData) * yData;
else
% Based on the Chi2 distribution, the greatest probability density 
% of the value of the 2 * J form ('yData' - 'H' * 'Coefficients') * 
% (('yData' - 'H' * 'Coefficients')') / 'Variance_yData' lies at the 
% value 'length_xData' - m - 1 - 2, where m is the number of 
% determined parameters (in our case two ('Slope' and 
% 'Intercept')) minus one (i.e. 'length_xData' - m - 1 - 2 = 
% 'length_xData' - (2 - 1) - 1 - 2 = 'length_xData' - 4). 
    Coefficients =H \ yData;
    Variance_yData = ((yData - H * Coefficients)') * ...
        (yData - H * Coefficients) / (length_xData - 4);
    CovarMat_SlopeIntercept = inv((H') * H) * Variance_yData;
    varargout = {Variance_yData, CovarMat_SlopeIntercept};
end

Slope = Coefficients(1);
Intercept = Coefficients(2);

end