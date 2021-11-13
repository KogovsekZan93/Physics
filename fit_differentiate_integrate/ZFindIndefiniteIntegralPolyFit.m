function yIndefiniteIntegralPolyFit = ZFindIndefiniteIntegralPolyFit(xData, yData, xIntegralPolyFit, PolyDegree, varargin)


pars = inputParser;

paramName = 'xIntegralPolyFit';
errorMsg = '''xIntegralPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralPolyFit);


[yIndefiniteIntegralPolyFit, pFitPolyFit] = ZFindBasicIntegralPolyFit(xData, yData, xIntegralPolyFit, PolyDegree);

DrawZIntegralPolyFitHandle = @DrawZIntegralPolyFit;
ColorFace = [0, 0, 1];
DrawZIntegralPolyFitInput = {xData, yData, xIntegralPolyFit(1), xIntegralPolyFit(end), ColorFace, pFitPolyFit};
DecideIfDrawZ(DrawZIntegralPolyFitHandle, DrawZIntegralPolyFitInput, varargin{:});

end