function [slope, intercept, varargout] = ...
    FindSimpleLinearRegressionCoefficients...
    (xData, yData, varargin)

pars = inputParser;

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