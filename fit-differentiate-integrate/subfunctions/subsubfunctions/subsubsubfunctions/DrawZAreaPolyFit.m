function DrawZAreaPolyFit...
    (xAreaPolyFitMin, xAreaPolyFitMax, ColorFace, pFitPolyFit)
%% Tool for plotting the area under the regression 
%% polynomial curve over an interval
% 
% Author: Žan Kogovšek
% Date: 4.27.2023
% Last changed: 4.27.2023
% 
%% Description
% 
% Given the input vector "pFitPolyFit" of the coefficients of the  
% regression polynomial fPolyFit of the data points of the 
% functon f (Y = f(X)), the values of the X variable the 
% "xAreaPolyFitMin" value and the "xAreaPolyFitMax" value, and 
% the vector "ColorFace", this function plots the area under the 
% regression polynomial curve from "xAreaPolyFitMin" to 
% "xAreaPolyFitMax", the color of the area being defined by 
% the RGB triplet of numbers of the "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZAreaPolyFit...
% (xAreaPolyFitMin, xAreaPolyFitMax, ColorFace, pFitPolyFit)
% 
% The "xAreaPolyFitMin" parameter and the "xAreaPolyFitMax" 
% parameter are two values of the X variable and are the lower 
% and the upper boundary, respectively, of the area to be plotted 
% using this function under the regression polynomial curve of 
% the fPolyFit function. The "xAreaPolyFitMax" value must be 
% greater than the "xAreaPolyFitMin" value. 
% 
% "ColorFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the regression polynomial curve of the 
% fPolyFit function from the value "xAreaPolyFitMin" to the 
% "xAreaPolyFitMax" value. The three real numbers must be 
% values of the [0, 1] interval. 
% 
% pFitPolyFit is the vertical vector of the coefficients of the 
% regression polynomial fPolyFit. The regression polynomial 
% fPolyFit has the form fPolyFit(X) = "a_n" * (X^n) + 
% "a_(n - 1)" * (X^(n - 1)) + ... + "a_1" * X + "a_0" and the 
% "pFitPolyFit" vector must have the form 
% ["a_n"; "a_(n - 1)"; ...; "a_1"; "a_0"]. 


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

% The parameter "N" is set to be "N" = 10 000 and represents 
% the number of points for the area under the regression 
% polynomial curve plot. With this setting, the number of points 
% is typically sufficient to create a convincing illusion of the 
% plotted curve of the function fPolyFit being smooth (as the 
% actual fPolyFit function is, in fact, a smooth function). 
N = power(10, 4);

XFitPolyFit = (linspace(xAreaPolyFitMin, xAreaPolyFitMax, N))';
YFitPolyFit = polyval(pFitPolyFit, XFitPolyFit);

h = area(XFitPolyFit, YFitPolyFit);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end