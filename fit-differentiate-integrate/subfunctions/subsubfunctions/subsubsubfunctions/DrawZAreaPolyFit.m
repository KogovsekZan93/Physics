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

% The parameter "N" is set to be "N" = 1000 and represents the 
% number of points for both the regression polynomial curve and 
% the area under the regression polynomial curve. With this 
% setting, the number of points is typically sufficient to create a 
% convincing illusion of the plotted curve of the function fPolyFit 
% being smooth (as the actual fPolyFit function is, in fact, a 
% smooth function). 
N = power(10, 4);

XFitPolyFit = (linspace(xAreaPolyFitMin, xAreaPolyFitMax, N))';
YFitPolyFit = polyval(pFitPolyFit, XFitPolyFit);

h = area(XFitPolyFit, YFitPolyFit);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end