function DrawZAreaPolyFit...
    (xAreaPolyFitMin, xAreaPolyFitMax, ColorFace, pFitPolyFit)
%DRAWZAREAPOLYFIT Summary of this function goes here
%   Detailed explanation goes here
pars = inputParser;

paramName = 'xAreaPolyFitMin';
errorMsg = '''xAreaPolyFitMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaPolyFitMax';
errorMsg = ...
    '''xAreaPolyFitMax'' must be a number which is greater than ''xAreaPolyFitMax''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xAreaPolyFitMax > xAreaPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xAreaPolyFitMin, xAreaPolyFitMax, ColorFace, ...
    pFitPolyFit);

N = power(10, 4);

XFitPolyFit = (linspace(xAreaPolyFitMin, xAreaPolyFitMax, N))';
YFitPolyFit = polyval(pFitPolyFit, XFitPolyFit);
h = area(XFitPolyFit, YFitPolyFit);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end