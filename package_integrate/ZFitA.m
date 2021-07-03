function [yFitA, varargout] = ZFitA(xData, yData, xFitA, varargin)


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Accuracy';
defaultVal = 1;
errorMsg = '''Accuracy'' must be a natural number which is lower than length(xData).';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0 && x < length(xData), errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
addParameter(pars, paramName, defaultVal);

parse(pars, xData, varargin{:});

acc = pars.Results.Accuracy;
mode = pars.Results.Mode;


[Ipoints, Smatrix] = GetIpointsSmatrix(xData, acc + 1, mode);

yFitA = IpointsSmatrixFitValue(xData, yData, xFitA, Ipoints, Smatrix);

varargout = {Ipoints, Smatrix};

end