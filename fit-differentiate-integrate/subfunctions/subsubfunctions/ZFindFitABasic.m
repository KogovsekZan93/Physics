function [yFitA, varargout] = ZFindFitABasic(xData, yData, xFitA, varargin)


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PseudoAccuracy';
defaultVal = 1;
errorMsg = '''PseudoAccuracy'' must be a nonnegative integer which is lower than length(xData).';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 0 && mod(x,1) == 0 && x < length(xData), errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
addParameter(pars, paramName, defaultVal);

parse(pars, xData, varargin{:});

psacc = pars.Results.PseudoAccuracy;
mode = pars.Results.Mode;


[Ipoints, Smatrix] = GetIpointsSmatrix(xData, psacc + 1, mode);

yFitA = EvaluateIpointsSmatrixFit(xData, yData, xFitA, Ipoints, Smatrix);

varargout = {Ipoints, Smatrix};

end