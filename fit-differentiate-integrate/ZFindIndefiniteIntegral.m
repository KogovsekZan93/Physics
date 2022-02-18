function yIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, xIntegral, varargin)

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
    yIndefiniteIntegral = ZFindIndefiniteIntegralA(xData, yData, xIntegral, TypeDeletedList{:});
else
    if strcmp(type, 'Spline')
        yIndefiniteIntegral = ZFindIndefiniteIntegralSpline(xData, yData, xIntegral, TypeDeletedList{:});
    else
        yIndefiniteIntegral = ZFindIndefiniteIntegralPolyFit(xData, yData, xIntegral, TypeDeletedList{:});
    end
end

end