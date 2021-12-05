function DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, varargin)
%ZINTEGRALALIMITS Summary of this function goes here
%   Detailed explanation goes here

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
    DefiniteIntegral = ZFindDefiniteIntegralA(xData, yData, Limits, TypeDeletedList{:});
else
    if strcmp(type, 'Spline')
        DefiniteIntegral = ZFindDefiniteIntegralSpline(xData, yData, Limits, TypeDeletedList{:});
    else
        DefiniteIntegral = ZFindDefiniteIntegralPolyFit(xData, yData, Limits, TypeDeletedList{:});
    end
end

end