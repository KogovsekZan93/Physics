function [yDerivativePolyFit, varargout] = ZFindDerivativePolyFit(xData, yData, xDerivativePolyFit, PolyDegree, varargin)


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativePolyFit';
errorMsg = '''xDerivativePolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Figure';
defaultVal = 0;
errorMsg = '''Figure'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >= 0 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, xDerivativePolyFit, varargin{:});

ordDeriv = pars.Results.OrdDeriv;
figr = pars.Results.Figure;


[yDerivativePolyFit, pDerivativePolyFit, pFitPolyFit] = ZFindBasicDerivativePolyFit(xData, yData, xDerivativePolyFit, PolyDegree, 'OrdDeriv', ordDeriv);
varargout = {pDerivativePolyFit};

DrawZFitPolyFitHandle = @DrawZFitPolyFit;
DrawZFitPolyFitInput = {xData, yData, min(xData(1), xDerivativePolyFit(1)), max(xData(end), xDerivativePolyFit(end)), pFitPolyFit};
DecideIfDrawZ(DrawZFitPolyFitHandle, DrawZFitPolyFitInput, 'Figure', figr);

end