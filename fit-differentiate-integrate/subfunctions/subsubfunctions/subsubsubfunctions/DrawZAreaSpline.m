function DrawZAreaSpline...
    (xAreaSplineMin, xAreaSplineMax, ColorFace, ppFitSpline)
%DRAWZAREASPLINE Summary of this function goes here
%   Detailed explanation goes here

pars = inputParser;

paramName = 'xAreaSplineMin';
errorMsg = '''xAreaSplineMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaSplineMax';
errorMsg = ...
    '''xAreaSplineMax'' must be a number which is greater than ''xAreaSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xAreaSplineMax > xAreaSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xAreaSplineMin, xAreaSplineMax, ColorFace, ...
    ppFitSpline);

% The parameter "N" is set to be "N" = 10 000 and represents 
% the number of points for both the interpolating spline curve 
% and the area under the interpolating spline curve. With this 
% setting, the number of points is typically sufficient to create a 
% convincing illusion of the plotted curve of the function fA being 
% smooth (as the actual fA function is, in fact, a smooth 
% function). 
N = power(10, 4);

XFitSpline = (linspace(xAreaSplineMin, xAreaSplineMax, N))';
YFitSpline = ppval(ppFitSpline, XFitSpline);
h = area(XFitSpline, YFitSpline);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;



end