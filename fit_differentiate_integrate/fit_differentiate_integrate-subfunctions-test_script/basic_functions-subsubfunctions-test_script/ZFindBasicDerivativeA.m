function [yDerivativeA, varargout] = ZFindBasicDerivativeA(xData, yData, xDerivativeA, varargin)


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

parse(pars, xData, varargin{:});

ordDeriv = pars.Results.OrdDeriv;
acc = pars.Results.Accuracy;
mode = pars.Results.Mode;


nA = acc + ordDeriv;

if nA > length(xData)
    error('''Accuracy + OrdDeriv'' must be equal to or lower than ''length(xData)''.');
end


[Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode);
varargout = {Ipoints, Smatrix};

yDerivativeA = EvaluateIpointsSmatrixDerivative(xData, yData, xDerivativeA, ordDeriv, Ipoints, Smatrix);

end