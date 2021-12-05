function [yFitA, varargout] = ZFindFit(xData, yData, xFit, varargin)

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
    [yFitA, Ipoints, Smatrix] = ZFindFitA(xData, yData, xFit, TypeDeletedList{:});
    varargout = {Ipoints, Smatrix};
else
    if strcmp(type, 'Spline')
        yFitA = ZFindFitSpline(xData, yData, xFit, TypeDeletedList{:});
    else
        [yFitA, pFitPolyFit] = ZFindFitPolyFit(xData, yData, xFit, TypeDeletedList{:});
        varargout = {pFitPolyFit};
    end
end

end