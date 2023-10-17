function [slope, intercept, varargout] = ...
    FindSimpleLinearRegressionCoefficients...
    (xData, yData, varargin)
%% Tool for finding the slope and the intercept of the 
%% simple linear regression curve of the data
% 
% Author: Žan Kogovšek
% Date: 10.17.2023
% Last changed: 10.17.2023
% 
%% Description
% 
% Given the input column vectors "xData" of the values "xData"(i) 
% of the independent variable X and the column vector "yData" 
% of values "yData"(i) of the dependent variable 
% Y = f(X) = X * a + b, this function returns the estimated values 
% for the a ("slope") and b ("intercept") parameters using simple 
% linear regression of the data pairs ("xData"(i), "yData"(i)). 
% Additionally, if no additional input parameters are supplied, the 
% estimated variance of the "yData"(i) values can be obtained as 
% the optional output parameter "variance_yData". If the optional 
% input parameter "CovarianceMatrix", which is the covariance 
% matrix of the values of the "yData" vector, is supplied, the 
% optional output parameter is the "CovarMat_SlopeIntercept" 
% matrix, which is the covariance matrix of the "slope" and 
% "intercept" parameters. 
% 
%% Variables
% 
% This function has the form of [slope, intercept, varargout] = ...
% FindSimpleLinearRegressionCoefficients...
% (xData, yData, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function 
% Y = f(X) = X * a + b ("yData" = f("xData")) where the a and the 
% b parameters are to be estimated by this function by using 
% simple linear regression. 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. 
% 
% "varargin" represents the additional input parameter 
% "CovarMat_yData". "CovarMat_yData" is the covariance matrix 
% of the values of the "yData" vector. It must be a matrix of real 
% numbers. 
% 
% Both the "Slope" parameter and the "Intercept" parameter are 
% estimates of the a parameter and b parameter, respectively, 
% calculated by simple linear regression of the data pairs 
% ("xData"(i), "yData"(i)) and, if supplied, by the taking into the 
% account the covariance of the "yData"(i) values provided by 
% the optional "CovarMat_yData" matrix. 
% 
% varargout.........

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
    coefficients = ...
        (CovarMat_SlopeIntercept * (H') / CovarMat_yData) * yData;
else
    coefficients =H \ yData;
    variance_yData = (yData - H * coefficients) * ...
        ((yData - H * coefficients)') / (length_xData - (2 - 1) - 1);
    varargout = {variance_yData};
end

slope = coefficients(1);
intercept = coefficients(2);

end