function [yDerivative, varargout] = ZFindDerivative(xData, yData, xDerivative, varargin)

[TypeList, TypeDeletedList] = SeparateOptionalParameter(varargin, 'Type');

pars = inputParser;

paramName = 'Type';
defaultVal = 'A';
errorMsg = '''Type'' must be either "A", "Spline", or "PolyFit".';
validationFcn = @(x)assert(strcmp(x, 'A') || strcmp(x, 'Spline') ...
    || strcmp(x, 'PolyFit') , errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, TypeList{:});

type = pars.Results.Type;

if strcmp(type, 'A')
    yDerivative = ZFindDerivativeA(xData, yData, xDerivative, TypeDeletedList{:});
    varargout = {};
else
    if strcmp(type, 'Spline')
        [yDerivative, ppDerivativeSpline] = ZFindDerivativeSpline(xData, yData, xDerivative, TypeDeletedList{:});
        varargout = {ppDerivativeSpline};
    else
        [yDerivative, pFitPolyFit] = ZFindDerivativePolyFit(xData, yData, xDerivative, TypeDeletedList{:});
        varargout = {pFitPolyFit};
    end
end

end