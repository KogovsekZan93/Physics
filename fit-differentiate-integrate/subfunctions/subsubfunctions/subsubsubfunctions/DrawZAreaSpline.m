function DrawZAreaSpline...
    (xAreaSplineMin, xAreaSplineMax, ColorFace, ppFitSpline)
%% Tool for plotting the area under the interpolating spline curve over an 
%% interval
% 
% Author: Žan Kogovšek
% Date: 4.27.2023
% Last changed: 6.5.2024
% 
%% Description
% 
% Given the input piecewise polynomial structure 'ppFitSpline' of the 
% interpolating cubic spline polynomial fSpline of the functon f 
% (Y = f(X)), the values of the X variable the 'xAreaSplineMin' value and 
% the 'xAreaSplineMax' value, and the vector 'ColorFace', this function 
% plots the area under the spline curve from 'xAreaSplineMin' to 
% 'xAreaSplineMax', the color of the area being defined by the RGB triplet 
% of numbers of the 'ColorFace' vector. 
% 
%% Variables
% 
% This function has the form of DrawZAreaSpline...
% (xAreaSplineMin, xAreaSplineMax, ColorFace, ppFitSpline)
% 
% The 'xAreaSplineMin' parameter and the 'xAreaSplineMax' parameter are 
% two values of the X variable and are the lower and the upper boundary, 
% respectively, of the area to be plotted using this function under the 
% interpolating spline curve of the fSpline function. The 'xAreaSplineMax' 
% value must be greater than the 'xAreaSplineMin' value. 
% 
% 'ColorFace' is the horizontal vector of three real numbers which 
% represents the RGB triplet which is to be used to set the color of the 
% area under the interpolating spline curve of the fSpline function from 
% the 'xAreaSplineMin' value to the 'xAreaSplineMax' value. The three real 
% numbers must be values of the [0, 1] interval. 
% 
% 'ppFitSpline' is the piecewise polynomial structure of the interpolating 
% cubic spline polynomial fSpline. 


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
errorMsg = '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && length(x) == 3, ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xAreaSplineMin, xAreaSplineMax, ColorFace, ppFitSpline);

% The parameter 'N' is set to be 'N' = 10 000 and represents the number of 
% points for the area under the cubic spline curve plot. With this 
% setting, the number of points is typically sufficient to create a 
% convincing illusion of the plotted fSpline function curve being smooth 
% (as the actual fSpline function is, in fact, a smooth function). 
N = power(10, 4);

XFitSpline = (linspace(xAreaSplineMin, xAreaSplineMax, N))';
YFitSpline = ppval(ppFitSpline, XFitSpline);

h = area(XFitSpline, YFitSpline);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end