function yDerivativeA = ZFindDerivative(xData, yData, xDerivativeA, varargin)
[FigureParameter, NonFigureParameters] = SeparateOptionalParameter(varargin, 'Figure');


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativeA';
errorMsg = '''xDerivativeA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xDerivativeA);


[yDerivativeA, Ipoints, Smatrix] = ZFindBasicDerivativeA(xData, yData, xDerivativeA, NonFigureParameters{:});

DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, min(xDerivativeA(1), xData(1)), max(xDerivativeA(end), xData(end)), Ipoints, Smatrix};
DecideIfDrawZ(DrawZFitAHandle, DrawZFitAInput, FigureParameter{:});

end